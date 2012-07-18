require 'spec_helper'

describe Complexity do
  before(:each) do
    @attr= {
        :name => "Test Complexity Template",
        :description => "Test Complexity Template Description"
    }
  end

  context "name" do

	  it "should be added" do
		complexity = Complexity.new(@attr)
		complexity.respond_to?(:name).should == true
	  end

	  it "should not be nil" do
		new_attr = @attr.clone
		new_attr.delete(:name)

		complexity = Complexity.new(new_attr)
		complexity.should_not be_valid
	  end

  end

  context "description" do
    it "should have a description" do
    	complexity = Complexity.new(@attr)
      complexity.respond_to?(:description).should == true
    end
  end
end

# == Schema Information
#
# Table name: complexities
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

