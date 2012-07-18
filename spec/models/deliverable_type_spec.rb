require "rspec"

describe DeliverableType do

  before (:each) do
    @attr= {
        :name => "Test Deliverable",
        :description => "Test Deliverable Description"
    }
  end

  context "name" do

    it "should be there" do
      phase_type = DeliverableType.new(@attr)
      phase_type.respond_to?(:name).should == true
    end

    it "should not be nil" do
      new_attr = @attr.clone
      new_attr.delete(:name)

      d = DeliverableType.new(new_attr)
      d.should_not be_valid
    end

  end

  it "should have a description" do
    deliverable_type = DeliverableType.new(@attr)
    deliverable_type.respond_to?(:description).should == true
  end


  context "unit" do
      before(:each) do
        @unit=Factory(:unit)
        @unit.save
        @dt = DeliverableType.new(:name=>"dt",:unit=>@unit)
        @dt.save
      end


  	  it "should have a unit" do
        @dt.respond_to?(:unit).should == true
  	  end
  end

end
# == Schema Information
#
# Table name: deliverable_types
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  unit_id     :integer
#

