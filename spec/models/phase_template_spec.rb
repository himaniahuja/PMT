require "rspec"

describe PhaseTemplate do

  before(:each) do
    @attr = {
        :name => "Test Phase",
        :description => "Test Phase Template Description"
    }
  end

  it "should create a new instance in database given valid attributes" do
    LifeCycle.create!(@attr);
  end

  context "name" do

    it "should exists" do
      phase_template = PhaseTemplate.create!(@attr);
      phase_template.respond_to?(:name).should == true;
    end

    it "should only accept a string with 2-60 characters" do
      too_long_name = "r"*61
      too_long_name_phase_template = PhaseTemplate.new(@attr.merge(:name => too_long_name))
      too_long_name_phase_template.should_not be_valid

      too_short_name = 'r'
      too_short_name_phase_template = PhaseTemplate.new(@attr.merge(:name => too_short_name))
      too_short_name_phase_template.should_not be_valid
    end

    it "should not be nil" do
      new_attr = @attr.clone
      new_attr.delete(:name)

      l = PhaseTemplate.new(new_attr)
      l.should_not be_valid
    end

  end

  it "should have a description" do
    phase_template = PhaseTemplate.new(@attr)
    phase_template.respond_to?(:description).should == true
  end

end



# == Schema Information
#
# Table name: phase_templates
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  description   :string(255)
#  life_cycle_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

