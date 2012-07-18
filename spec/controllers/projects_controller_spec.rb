require 'spec_helper'

describe ProjectsController do
  render_views

    before(:each) do
	  	@life_cycle = Factory(:life_cycle)
		@phase_template = Factory(:phase_template, :life_cycle => @life_cycle)
        user = Factory(:user)
        sign_in user
    end

  describe "GET 'new'" do
     it "should be successful" do
        get 'new'
        response.should be_success
      end
  end

  describe "POST 'create'" do

      before(:each) do
        @project = Factory(:project, :life_cycle => @life_cycle)
        @attr = {
            :name => @project.name,
            :description => @project.description,
            :is_finished => @project.is_finished,
            :life_cycle_id => @project.life_cycle_id,
            :owner => 1
          }
      end

      it "should create a project" do
        lambda do
          post :create, :project => @attr
		  project = Project.find(:last)
		  project.phases[0].name.should == @phase_template.name
        end.should change(Project, :count)
      end

      it "should be redirected upon success" do
        post :create, :project => @attr
        response.should be_redirect
      end

  end

  describe "GET 'show'" do

      before(:each) do
        @project = Factory(:project, :life_cycle => @life_cycle)
		@phase = Factory(:phase)
      	@owner = Factory(:user)
      	@project.phases << @phase
      end

      it "should be successful" do
        get :show, :id => @project.id
        response.should be_success
      end

      it "should find the right project" do
        get :show, :id => @project.id
        assigns(:project).should == @project
      end

  end


   describe "GET 'edit'" do

     before(:each) do
       @project = Factory(:project)
     end

     it "should be successful" do
        get :edit, :id => @project.id
        response.should be_success
      end
   end

   describe "POST 'update'" do

     before(:each) do
       @project = Factory(:project_with_involvements)
       @new_user = Factory(:user)
     end

     it "should delete the association when it is removed" do
       proj_attr = @project.attributes
       post :update, { :id => @project.id, :project => proj_attr, :users => [@project.users[0].username] }
       Project.find(@project.id).users.should_not include(@project.users[1])
     end

     it "should add the association when a user is added" do
       proj_attr = @project.attributes
       post :update, { :id => @project.id, :project => proj_attr, :users => [@project.users[0].username, @project.users[1].username, @new_user.username]}
       Project.find(@project.id).users.should include(@new_user)
     end

   end

  describe "POST 'archive'" do
    before do
      @project1 = Factory(:project, :is_finished => true)
      @project2 = Factory(:project, :is_archived => true, :is_finished => true)
    end

    it "should change unarchived project to archived" do
      target_value = !@project1.is_archived
      request.env['CONTENT_TYPE'] = 'application/json'
      post :archive, :id => @project1.id
      changed = Project.archived_and_unarchived.find(@project1.id)
      changed.is_archived.should == target_value
    end

    it "should change archived project to the unarchived project" do
      target_value = !@project2.is_archived
      request.env['CONTENT_TYPE'] = 'application/json'
      post :archive, :id => @project2.id
      changed = Project.archived_and_unarchived.find(@project2.id)
      changed.is_archived.should == target_value
    end
  end

  describe "DELETE 'project'" do
    before(:each) do
      @project = Factory(:project_with_involvements)
      @involvements = @project.involvements
      @sample_user = @involvements[0].user
      delete :destroy, :id => @project.id
    end

    it "should delete the project" do
      lambda {
        Project.find(@project.id)
      }.should raise_error(ActiveRecord::RecordNotFound)
      response.should redirect_to(root_path)
    end

    it "should also delete associated involvements" do
      @involvements.length.should_not == 0
      @involvements.each do |i|
        lambda {
          Involvement.find(i.id)
        }.should raise_error(ActiveRecord::RecordNotFound)
      end
    end

    it "should not delete the associated user" do
      lambda {
        User.find(@sample_user.id);
      }.should_not raise_error
    end
  end

end
