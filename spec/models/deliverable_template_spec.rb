require 'spec_helper'

describe DeliverableTemplate do

  before(:each) do
    @attr= {
        :name => "Test Template",
        :description => "Test Template Description"
    }
  end

  context "name" do

	  it "should be there" do
		deliverable_template = DeliverableTemplate.new(@attr)
		deliverable_template.respond_to?(:name).should == true
	  end

	  it "should not be nil" do
		new_attr = @attr.clone
		new_attr.delete(:name)

		deliverable_template = DeliverableTemplate.new(new_attr)
		deliverable_template.should_not be_valid
	  end

  end

  context "description" do

  	  it "should have a description" do
    	deliverable_template = DeliverableTemplate.new(@attr)
        deliverable_template.respond_to?(:description).should == true
  	  end
  end

end

# == Schema Information
#
# Table name: deliverable_templates
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  description       :text
#  phase_template_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#  type_id           :integer
#

