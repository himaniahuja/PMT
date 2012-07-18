# ==This controller creates, updates, deletes deliverables
class DeliverablesController < ApplicationController

  # GET /deliverables/new
  def new
    @deliverable = Deliverable.new
    @deliverable.phase_id = params[:phase_id]

	@deliverable_types = DeliverableType.find_types

	@units = Unit.find(:all, :order=> 'name')
	@deliverable_type = DeliverableType.new
	@deliverable_type.name = "< Ad Hoc >"
	@deliverable_type.id = -1

	@deliverable_types << @deliverable_type


    respond_to do |format|
      format.html
    end
  end

  # POST /deliverables/1
  def create
    @deliverable = Deliverable.new(params[:deliverable])
	@deliverable_types = DeliverableType.find_types
	@deliverable_type = DeliverableType.new(params[:deliverable_type])

	if @deliverable.deliverable_type_id == -1
	  @deliverable_type.adhoc = true
	  @deliverable.type = @deliverable_type
	end

    respond_to do |format|
      if @deliverable.save
        format.html { redirect_to(@deliverable.phase.project) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # GET /deliverables/1
  def show
	@deliverable = Deliverable.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end

  end

 # GET /deliverables/1/edit
  def edit
    @deliverable = Deliverable.find(params[:id])
	@deliverable_types = DeliverableType.find_types

	@type = DeliverableType.find(@deliverable.deliverable_type_id)

	@deliverable_types << @type

  end

  # PUT /projects/1
  def update
    @deliverable = Deliverable.find(params[:id])

    respond_to do |format|
      if @deliverable.update_attributes(params[:deliverable])
        format.html { redirect_to(@deliverable.phase.project) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /deliverables/1
  def destroy
    @deliverable = Deliverable.find(params[:id])
    @deliverable.destroy

    respond_to do |format|
      format.html { redirect_to(@deliverable.phase.project) }
    end
  end

  def toggle_is_done
    @deliverable = Deliverable.find(params[:id])
    @deliverable.is_done = !(@deliverable.is_done)

    respond_to do |format|
      if @deliverable.save
        format.html { redirect_to(@deliverable.phase.project) }
      else
        format.html { redirect_to(@deliverable.phase.project) }
      end
    end
  end

  def dropdown_update
	  if params[:deliverable_type_id] == "-1"
	    	@deliverable_type = DeliverableType.new
	    	@units = Unit.find(:all, :order=> 'name')
		respond_to do |format|
       		format.js
    	end
	  end
  end
end
