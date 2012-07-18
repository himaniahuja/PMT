require 'spec_helper'

describe HomeController do

  describe "GET 'home'" do
    it "should be successful" do
      pending 'will be implemented later'
      get 'home'
      response.should be_success
    end
  end

  describe "POST 'update_effort'" do
    before(:each) do
      @user = Factory(:user)
      sign_in @user
      @project = Factory :project
      @phase = Factory(:phase,:project_id=> @project )
      @deliverable = Factory(:deliverable,:phase_id=> @phase)
      Involvement.create!(:user_id=>@user,:project_id=>@project)
    end
    it "should successfully got projects of the user" do
      post 'update_effort',:deliverable_id => @deliverable.id
      assigns(:projects).should == [@project]
    end

    it "should successfully got phase of specific project" do
      post 'update_effort',:deliverable_id => @deliverable.id
      assigns(:phases).should == [@deliverable.phase]
    end

    it "should successfully got deliverable of specific project" do
      post 'update_effort',:deliverable_id => @deliverable.id
      deliverables = assigns(:deliverables)

      deliverables.each do |d|
        Deliverable.where(:id => d.id).length.should == 1
      end
    end
  end
end
