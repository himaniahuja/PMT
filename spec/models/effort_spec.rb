require 'spec_helper'

describe Effort do
  #pending "add some examples to (or delete) #{__FILE__}"

  before (:each) do
    @deliverable_test= Factory :deliverable
    @user_test = Factory :user
    @attrs = {
      :date_of_logging => Date.new(2011,1,1),
      :time_spent => 1.0,
      :interrupt_time => 0.5
    }
  end

  it "should create an effort" do
    new_attrs = @attrs
    new_attrs[:deliverable_id] = @deliverable_test.id
    new_attrs[:user_id] = @user_test.id
    Effort.create!(new_attrs)
  end

  it "should have the user attribute" do
    effort = Effort.new(:deliverable_id=>@deliverable_test.id,:user_id=>@user_test.id)
    effort.owner.should == @user_test

  end

  it "should have the deliverable attribute" do
    effort = Effort.new(:deliverable_id=>@deliverable_test.id,:user_id=>@user_test.id)
    effort.deliverable.should == @deliverable_test
  end


end
