require "rspec"

describe Estimation do

  before (:each) do
    @complexity_test = Factory :complexity
    @deliverable_test = Factory :deliverable

    @attr= {
        :complexity => @complexity_test,
        :deliverable => @deliverable_test,
        :effort => 9000,
        :size => 1,
        :productivity_rate => 1/90000
    }
  end

  it "should create an estimation" do
    Estimation.create! @attr
  end

  it "should have the complexity attribute" do
    estimation = Estimation.new @attr
    estimation.complexity.should == @complexity_test
  end

  it "should have the deliverable attribute" do
    estimation=Estimation.new @attr
    estimation.deliverable.should == @deliverable_test
  end

  it "should have a productivity rate" do
    estimation = Estimation.new(@attr)
    estimation.respond_to?(:productivity_rate).should == true
  end

  it "should have a size" do
    estimation = Estimation.new(@attr)
    estimation.respond_to?(:size).should == true
  end

  it "should have a effort" do
    estimation = Estimation.new(@attr)
    estimation.respond_to?(:effort).should == true
  end
end

# == Schema Information
#
# Table name: estimations
#
#  id                :integer         not null, primary key
#  productivity_rate :float
#  effort            :float
#  size              :float
#  deliverable_id    :integer
#  complexity_id     :integer
#  created_at        :datetime
#  updated_at        :datetime
#

