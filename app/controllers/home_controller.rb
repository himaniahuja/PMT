class HomeController < ApplicationController
  before_filter  :authenticate_user!

  def home
    @effort = Effort.new
    @projects = Project.on_going.find_user_related(current_user.id)
    @phases = get_associated_phases(@projects)
    @deliverables = get_associated_deliverables(@phases)
    @recent_deliverables = get_recent_deliverables

    respond_to do |format|
      format.html
    end
  end

  def update_effort
    @dr = Deliverable.find(params[:deliverable_id])
    @effort = Effort.new
    @projects = Project.on_going.find_user_related(current_user.id)
    @phases = get_associated_phases([@dr.phase.project])
    @deliverables = get_associated_deliverables([@dr.phase])
    @recent_deliverables = get_recent_deliverables

    respond_to do |format|
      format.js
    end
  end

  def get_recent_deliverables
    Deliverable.recent_deliverables(current_user.id)
  end

  def update_phase_select
    @phases = Phase.where(:project_id => params[:id])
    @deliverables = get_associated_deliverables(@phases)

    respond_to do |format|
      format.js
    end
  end

  def update_deliverable_select
    @deliverables = Deliverable.where(:phase_id => params[:id])

    respond_to do |format|
      format.js
    end
  end

  private
  def get_associated_phases(projects)
    if projects.length > 0
      phases = Phase.where(:project_id => projects[0].id)
    else
      phases = []
    end

    return phases
  end

  private
  def get_associated_deliverables(phases)
    if phases.length > 0
      deliverables = Deliverable.where({ :phase_id => phases[0].id , :is_done => false })
    else
      deliverables = []
    end

    return deliverables
  end

end
