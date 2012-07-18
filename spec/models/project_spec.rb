require "rspec"

describe Project do

  before(:each) do
    @attr= {
        :name => "Test Project",
        :description => "Test project description",
        :start_date => Date.new(2010, 1, 1),
        :estimated_end_date => Date.new(2010, 1, 1),
        :is_finished => true,
        :is_archived => false
    }
  end

  it "should create an instance in database with valid attributes" do
    project = Project.create!(@attr)
    project.new_record?.should == false
  end

  describe "name" do

    it "has to be there" do
      project = Project.new(@attr)
      project.respond_to?(:name).should == true
    end

    it "should only accept a string with 2-60 characters" do
      too_long_name = "r"*61
      too_long_name_project= Project.new(@attr.merge(:name => too_long_name))
      too_long_name_project.should_not be_valid

      too_short_name = 'r'
      too_short_name_project = Project.new(@attr.merge(:name => too_short_name))
      too_short_name_project.should_not be_valid
    end

    it "should not be nil" do
      new_attr = @attr.clone
      new_attr.delete(:name)

      p = Project.new(new_attr)
      p.should_not be_valid
    end
  end


  it "should have a description" do
    project = Project.new(@attr)
    project.respond_to?(:description).should == true
  end

  it "should have many phases" do
    project = Project.new(@attr)
    project.respond_to?(:phases).should == true
  end

  it "should have start date" do
    project = Project.new(@attr)
    project.respond_to?(:start_date).should == true
  end

  it "should have end date" do
    project = Project.new(@attr)
    project.respond_to?(:estimated_end_date).should == true
  end

  it "should have finished tag" do
    project = Project.new(@attr)
    project.respond_to?(:is_finished).should == true
  end

  it "should have an owner" do
    project = Project.new(@attr)
    project.respond_to?(:owner).should == true
  end

  it "should have an attribute indicating whether it is archived" do
    project = Project.new(@attr)
    project.respond_to?(:is_archived).should == true
  end

  describe "estimated_efforts" do
    before(:each) do
      @attr_project= {
        :name => "Test Project",
        :description => "Test project description",
        :start_date => Date.new(2010, 1, 1),
        :estimated_end_date => Date.new(2010, 1, 1),
        :is_finished => true
      }
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
      @project=Project.create!(@attr_project)
      @phase = Phase.create!(@attr_pha)
      @deliverable = Deliverable.create!(@attr_deli)
      @deliverable.estimation = @estimation
      @phase.deliverables = [@deliverable]
      @project.phases =[@phase]
    end

    it "should have estimated_efforts method" do
      @project.estimated_efforts.should == @estimation.effort
    end
  end

  describe "search method" do
    before(:each) do
      @p1=Factory(:project)
      @p2=Factory(:project)
    end

    it "should return the single result" do
      Project.search(@p1.name).should == [@p1]
      Project.search(@p2.name).should == [@p2]
    end
  end

  context "scope" do

    before(:each) do
      @p1=Factory(:project)
      @p2=Factory(:project)
      @p1.is_archived = true
      @p1.save
    end

    describe "unarchived" do
      it "should have unarchived projects"  do
        Project.unarchived.search(@p2.name).should == [@p2]
      end

      it "should not show archived projects"  do
        Project.unarchived.search(@p1.name).should == []
      end
    end

    describe "archived" do
      it "should have archived projects" do
        Project.archived.search(@p1.name).should == [@p1]
      end

      it "should not have unarchived projects" do
        Project.archived.search(@p2.name).should == []
      end
    end
  end
end




# == Schema Information
#
# Table name: projects
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  description        :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  start_date         :date
#  estimated_end_date :date
#  is_finished        :boolean
#  owner              :integer
#  life_cycle_id      :integer
#  is_archived        :boolean
#

