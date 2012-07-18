require 'spec_helper'

describe DeliverablesController do
  context "any user" do
    before(:each) do
      user = Factory(:user)
      sign_in user

      @life_cycle = Factory(:life_cycle)
      @phase_template = Factory(:phase_template, :life_cycle => @life_cycle)
      @project = Factory(:project, :life_cycle => @life_cycle)
      @phase = Factory(:phase)
      @owner = Factory(:user)
        @project.phases << @phase
      @deliverable_type = Factory(:deliverable_type)

    end

    describe "GET 'new'" do
      it "should be successful" do
        get 'new', :phase_id => @phase.id
        response.should be_success
      end
    end

    describe "POST 'create'" do
      before(:each) do
        @attr = {
            :name => "Test Deliverable",
            :description => "Test Description",
            :phase_id => @phase.id,
            :deliverable_type_id => @deliverable_type.id
          }
      end

      it "should create a deliverable and be redirected" do
        lambda do
          post :create, :deliverable => @attr
        end.should change(Deliverable, :count)

        response.should be_redirect
      end
    end

    describe "GET 'show'" do

      before(:each) do
        @attr = {
            :name => "Test Deliverable",
            :description => "Test Description",
            :phase_id => @phase.id,
            :deliverable_type_id => @deliverable_type.id
          }
        @deliverable= Deliverable.create(@attr)
        @estimation = Factory(:estimation, :deliverable => @deliverable)
      end


      it "should be successful" do
        get :show, :id => @deliverable.id
        response.should be_success
      end

      it "should find the right deliverable" do
        get :show, :id => @deliverable.id
        assigns(:deliverable).should == @deliverable
      end
    end

    describe "GET 'edit'" do

      before(:each) do
        @attr = {
            :name => "Test Deliverable",
            :description => "Test Description",
            :phase_id => @phase.id,
            :deliverable_type_id => @deliverable_type.id
          }
        @deliverable= Deliverable.create(@attr)
        @estimation = Factory(:estimation, :deliverable => @deliverable)
      end

      it "should be successful" do
        get :edit, :id => @deliverable.id
        response.should be_success
      end

    end

    describe "GET 'update'" do

      before(:each) do
        @attr = {
            :name => "Test Deliverable",
            :description => "Test Description",
            :phase_id => @phase.id,
            :deliverable_type_id => @deliverable_type.id
        }
        @deliverable= Deliverable.create(@attr)
        @estimation = Factory(:estimation, :deliverable => @deliverable)
      end

      it "should not update the project" do
        lambda do
          post :update, :id => @deliverable.id
        end.should_not change(Deliverable, :count)
      end

    end

    describe "POST 'toggle_is_done'" do

      it "should toggle the is_done attribute" do
        deliverable = Factory(:deliverable_with_phase_and_project)
        prev_bool = deliverable.is_done
        post :toggle_is_done, :id => deliverable.id

        deliverable = Deliverable.find(deliverable.id)
        deliverable.is_done.should == !prev_bool
        response.should redirect_to(:controller => 'projects', :action => 'show', :id => deliverable.phase.project.id)
      end
    end
  end
end