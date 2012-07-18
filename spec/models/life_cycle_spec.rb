require "rspec"

describe LifeCycle do

  before(:each) do
    @attr = {
        :name => "Test Lifecycle",
        :description => "Test Lifecycle description"
    }
  end

  it "should create a new instance in database given valid attributes" do
    LifeCycle.create!(@attr);
  end

  context "name" do

    it "should exists" do
      life_cycle = LifeCycle.create!(@attr);
      life_cycle.respond_to?(:name).should == true;
    end

    it "should only accept a string with 2-40 characters" do
      too_long_name = "r"*41
      too_long_name_life_cycle = LifeCycle.new(@attr.merge(:name => too_long_name))
      too_long_name_life_cycle.should_not be_valid

      too_short_name = 'r'
      too_long_name_life_cycle = LifeCycle.new(@attr.merge(:name => too_short_name))
      too_long_name_life_cycle.should_not be_valid
    end

    it "should not be nil" do
      new_attr = @attr.clone
      new_attr.delete(:name)

      l = LifeCycle.new(new_attr)
      l.should_not be_valid
    end

  end

  it "should have a description" do
    life_cycle = LifeCycle.new(@attr)
    life_cycle.respond_to?(:description).should == true
  end

  it "should have many phase templates" do
    life_cycle = LifeCycle.new(@attr)
    life_cycle.respond_to?(:phase_templates).should == true
  end

end

# == Schema Information
#
# Table name: life_cycles
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

