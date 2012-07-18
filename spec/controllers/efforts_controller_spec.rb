require 'spec_helper'

describe EffortsController do
  context "any user" do
    before do
      @user = Factory(:user)
      sign_in @user
      @deliverable = Factory(:deliverable)
    end

    describe "GET 'new'" do
      it "should appropriately render the new effort log form" do

        get 'new', :deliverable_id => @deliverable.id

        response.should_not be_redirect
        assigns(:effort).deliverable.id.should == @deliverable.id
        response.should render_template("new")
      end

    end

    describe "POST 'create'" do
      it "should save the effort when correct information is entered" do
        start_time = DateTime.now
        param_dlv = {
          'deliverable_id' => @deliverable.id,
          'date_of_logging' => '2011-01-01',
          'time_spent' => '4',
          'interrupt_time' => '1'
        }
        post 'create', :effort => param_dlv

        efforts = Effort.where('created_at >= ?', start_time)
        efforts.length.should == 1
        effort = efforts[0]
        effort.deliverable.id.should == @deliverable.id
        effort.date_of_logging.should == DateTime.new(2011, 1, 1)
        effort.time_spent.should.should == 4
        effort.interrupt_time.should == 1
        effort.owner.id.should == @user.id
      end
    end

    describe "UPDATE " do
      pending "none"
    end

  end


end
