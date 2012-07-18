# =This Controller handles the pages for the project
# We can add About us and other generic pages in later enhancements

class PagesController < ApplicationController

  before_filter  :authenticate_user!

  def showall
     @projects = Project.archived_and_unarchived.paginate(:page => params[:page],:per_page =>10,
                                  :order => 'is_finished')
  end

  def showmy
    # @projects = []
	  # Involvement.find_all_by_user_id(current_user.id).each do |i|
    #  @projects << i.project
    # end

    # @projects = @projects.paginate(:page => params[:page],:per_page =>10, :order => 'is_finished')

    @projects = Project.unarchived.find_user_related(current_user.id).paginate(:page => params[:page],:per_page =>10,
                                  :order => 'is_finished')
  end

    # PUT projects/search_update
  def search_update
    @projects = Project.search(params[:search]).paginate(:page => params[:page],:per_page =>10,
                                     :order => 'is_finished')
    respond_to do |format|
       format.js
     end
  end
end
