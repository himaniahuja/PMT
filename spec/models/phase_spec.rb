require "rspec"

describe Phase do

  before(:each) do
    @attr= {
        :name => "Test Phase",
        :description => "Test Phase description",
        :position => 0
    }
  end

  it "should create a new instance in database given valid attributes" do
    Phase.create!(@attr)
  end

  context "name" do

    it "should be there" do
      phase = Phase.new(@attr)
      phase.respond_to?(:name).should == true
    end

    it "should only accept strings with 2-60 characters" do
      too_long_name = 'r'*61
      too_long_name_phase = Phase.new(@attr.merge(:name => too_long_name))
      too_long_name_phase.should_not be_valid

      too_short_name = 'r'
      too_short_name_phase = Phase.new(@attr.merge(:name => too_short_name))
      too_short_name_phase.should_not be_valid
    end

    it "should not be nil" do
      new_attr = @attr.clone
      new_attr.delete(:name)

      p = Phase.new(new_attr)
      p.should_not be_valid
    end

  end

  it "should have a position" do
    phase = Phase.new(@attr)
    phase.respond_to?(:position).should == true
  end

  it "should have a description" do
    phase = Phase.new @attr
    phase.respond_to?(:description).should == true
  end

  it "should belong to a project" do
    phase = Phase.new(@attr)
    phase.respond_to?(:project).should == true
  end

  it "should have many deliverables" do
    phase = Phase.new(@attr)
    phase.respond_to?(:deliverables).should == true
  end

  context "estimated efforts" do
    before(:each) do

          @complexity_test = Factory :complexity
          @attr_esti= {
              :complexity => @complexity_test,
              :deliverable => @deliverable_test,
              :effort => 9000,
              :size => 1,
              :productivity_rate => 1/90000
          }
          @attr_pha= {
            :name => "Test Phase",
            :description => "Test Phase description",
            :position => 0
          }
          @attr_deli= {
            :name => "Test Deliverable",
            :description => "Test Deliverable Description",
          }

          @estimation = Estimation.create!(@attr_esti)
          @phase = Phase.create!(@attr_pha)
          @deliverable = Deliverable.create!(@attr_deli)
          @deliverable.estimation = @estimation
          @phase.deliverables = [@deliverable]

    end

    it "should have estimated_efforts method" do
      @phase.estimated_efforts.should == @estimation.effort
    end


  end

end


# == Schema Information
#
# Table name: phases
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  project_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#  position    :integer
#

