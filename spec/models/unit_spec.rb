require 'spec_helper'

describe Unit do

  before(:each) do
    @attr= {
        :name => "Test unit_of_measure_template",
        :description => "Test unit_of_measure_template Description"
    }
  end

  context "name" do

	  it "should be added" do
		unit = Unit.new(@attr)
		unit.respond_to?(:name).should == true
	  end

	  it "should not be nil" do
		new_attr = @attr.clone
		new_attr.delete(:name)

		unit = Unit.new(new_attr)
		unit.should_not be_valid
	  end

  end

  context "description" do
    it "should have a description" do
    	unit = Unit.new(@attr)
      unit.respond_to?(:description).should == true
    end
  end

end

# == Schema Information
#
# Table name: units
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

