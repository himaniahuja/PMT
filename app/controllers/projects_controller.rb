# ==This controller creates, updates, deletes projects
class ProjectsController < ApplicationController
  before_filter  :authenticate_user!
  load_and_authorize_resource

# Get/projects/index
  def index
    redirect_to(root_path)
  end

# GET /projects/new
  def new

    @project = Project.new
    @lifecycles = LifeCycle.find(:all, :order => 'name')
	1.times { @project.users.build }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end

  end

# Put /projects/new
  def create

    @project = Project.new(params[:project])
    @project.owner= current_user.id


	if !@project.life_cycle_id == nil?
	#copy phases from phase templates to phases of the project if the lifecycle is selected.
	 phases = PhaseTemplate.where(:life_cycle_id => @project.life_cycle.id)
     phases.each do |i|
           phase = Phase.new
           phase.name = i.name
           phase.description = i.description
		   @project.phases << phase

     # copy deliverables from deliverable template to deliverables for project.
		   deliverables = DeliverableTemplate.where(:phase_template_id => i.id)

		   deliverables.each do |d|
			  deliverable = Deliverable.new
			  deliverable.name = d.name
			  deliverable.description = d.description
			  deliverable.deliverable_type_id = d.type_id
	    	  phase.deliverables << deliverable
		   end
	 end
	end

	@project.users = []
	msg = @project.update_members(params[:users])
     unless msg.blank?
        redirect_to(new_project_path, :notice => msg)
        return
		end

    respond_to do |format|
       if @project.save
            @project.involvements.create!(:user_id => current_user.id)
            format.html { redirect_to(@project, :notice => 'Successfully created the Project.') }
            format.xml  { render :xml => @project, :status => :created, :location => @project }
       else
           format.html { render :action => "new" }
           format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
       end
     end

  end
  
# GET /projects/1
  def show
    @project = Project.find(params[:id])
    @owner = User.find(@project.owner)

    if !@project.life_cycle_id == nil?
        @lifecycle = LifeCycle.find(@project.life_cycle_id)
    end
    @phases=@project.phases

	@total_effort_for_project = @project.estimated_efforts

	respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end


# GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end
  
# PUT /projects/1
  def update
    @project= Project.find(params[:id])

	  new_users = params[:users]
    existing_users = []
    @project.users.each do |user|
      existing_users << user.username
    end

    if !(existing_users == new_users )
      existing_users.each do |e|
        if new_users.include?(e)
          new_users.delete(e)
        else
          remove_user = User.find_by_username(e)
          Involvement.delete_involvement(@project, remove_user)
        end
      end

      msg = @project.update_members(new_users)

        unless msg.blank?
          flash.now[:error] = msg
          render :action => 'edit'
          return
      end

      puts msg

    end

#	new_users1= existing_users | new_users
#	new_users2 = existing_users + new_users
#	new_users3 = existing_users - new_users
#	msg = @project.update_members(new_users)
#
#    unless msg.blank?
#        flash.now[:error] = msg
#        render :action => 'edit'
#        return
#    end

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to(@project, :notice => 'Project was successfully updated.') }
        format.xml  { head :ok }
       else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
       end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(root_path, :notice => "Project #{@project.name} was successfully deleted") }
    end
  end

  def archive
    project = Project.archived_and_unarchived.find(params[:id])
    respond_to do |format|
      if project.can_toggle_archive
        project.is_archived = !@project.is_archived
        if project.save
          format.js {
            if project.is_archived
              @message = "Project #{project.name} has been successfully archived"
            else
              @message = "Project #{project.name} has been successfully unarchived"
            end
          }
        else
          format.js {
            @message = "Error occurred while archiving/unarchiving project"
          }
        end
      else
        format.js {
          @message = "Cannot archive an unfinished project"
        }
      end
    end

  end

  # PUT projects/dropdown_update
  def dropdown_update
    @phase = Phase.find(params[:phase_id])
    respond_to do |format|
       format.js
     end
  end
end
