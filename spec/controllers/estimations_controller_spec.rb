require 'spec_helper'

describe EstimationsController do
  before(:each) do
    user = Factory(:user)
    sign_in user
  end

  describe "POST 'edit'" do
    before(:each) do
      @deliverable = Factory(:deliverable)
      @deliverable.stub!(:id).and_return(1)
      @estimation =  Factory(:estimation,:deliverable=>@deliverable)
    end
    it "should be successful" do
      post 'edit', :deliverable_id => @deliverable.id
      response.should be_success
    end
  end

  describe "PUT 'update'" do

      before(:each) do
        @phase = Factory(:phase)
        @deliverable_type = Factory(:deliverable_type)
        @attr = {
            :name => "Test Deliverable",
            :description => "Test Description",
            :phase_id => @phase.id,
            :deliverable_type_id => @deliverable_type.id
          }
        @deliverable= Deliverable.create(@attr)
        @estimation = Estimation.create!(:deliverable_id=>@deliverable)

      end

    it "should be successful" do
        put 'update', :deliverable_id => @deliverable.id, :estimation => @estimation
        response.should be_redirect
    end

  end
end
