class UsersController < ApplicationController
  #/users/:id
  def show
    @user = User.find(params[:id])
    @projects = @user.projects.paginate(:page => params[:page],:per_page =>10,
                                  :order => 'is_finished')
  end

end
