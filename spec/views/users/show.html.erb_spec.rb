require 'spec_helper'

describe "users/show.html.erb" do

  describe "User Information" do
     before(:each) do
      @user_t=Factory(:user)
      assign :user,@user_t

      @projects=(1..3).map{Factory(:project)}
      @projects.stub!(:total_pages).and_return(1)
      @user_t.stub!(:projects).and_return(@projects)
      assign :projects, @user_t.projects
      assign :user,@user_t
    end

    it "should have username" do
       render
       rendered.should have_content(@user_t.username)
    end

    it "should have email" do
      render
      rendered.should have_content(@user_t.email)
    end

  end

  describe "User involved Projects " do
    before(:each) do
      @user_t=Factory(:user)
      @projects=(1..3).map{Factory(:project)}
      @projects.stub!(:total_pages).and_return(1)
      @user_t.stub!(:projects).and_return(@projects)
      assign :user, @user_t
      assign :projects, @user_t.projects
    end

    it "should render partial _project.html.erb" do
      render
      rendered.should render_template(:partial => '_projects')
    end

    it "should show project names and descriptions" do
      render
      @user_t.projects.each do |p|
       rendered.should have_content(p.name)
       rendered.should have_content(p.description)
     end
    end

    it "should have links to the project overviews" do
      render
      @user_t.projects.each do |p|
       rendered.should have_selector('a',:content=>p.name)
      end

    end
  end
end