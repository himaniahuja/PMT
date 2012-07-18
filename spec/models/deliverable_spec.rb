require "rspec"

describe Deliverable do

  before(:each) do
    @attr= {
        :name => "Test Deliverable",
        :description => "Test Deliverable Description",
    }
  end

  describe "name" do

    it "should be there" do
      phase = Deliverable.new(@attr)
      phase.respond_to?(:name).should == true
    end

    it "should only accept a name with 2-60 characters" do
      too_long_name = 'r'*61
      too_long_name_deliverable = Deliverable.new(@attr.merge(:name => too_long_name))
      too_long_name_deliverable.should_not be_valid

      too_short_name = 'r'
      too_long_name_deliverable = Deliverable.new(@attr.merge(:name => too_short_name))
      too_long_name_deliverable.should_not be_valid
    end

    it "should not be nil" do
      new_attr = @attr.clone
      new_attr.delete(:name)

      d = Deliverable.new(new_attr)
      d.should_not be_valid
    end

  end

  it "should have a description" do
    deliverable = Deliverable.new(@attr)
    deliverable.respond_to?(:description).should == true
  end

  it "should have an owner" do
    pending "is Pending"
  end

  it "should belong to a phase" do
    deliverable = Deliverable.new(@attr)
    deliverable.respond_to?(:phase).should == true
  end

  describe "beginning date and due date" do

    it "should be there" do
      pending "is Pending"
    end

    it "should be after project beginning date" do
      pending " is Pending"
    end

  end

  it "should have a type" do
    deliverable = Deliverable.new(@attr)
    deliverable.respond_to?(:type).should == true
  end

  it "should return nil values when type is nil" do
    f = Factory(:deliverable)
    ret = f.historical_data(Factory(:complexity))

    ret[:effort][:min].should == nil
    ret[:effort][:max].should == nil
    ret[:effort][:avg].should == nil

    ret[:size][:min].should == nil
    ret[:size][:max].should == nil
    ret[:size][:avg].should == nil

    ret[:productivity_rate][:min].should == nil
    ret[:productivity_rate][:max].should == nil
    ret[:productivity_rate][:avg].should == nil
  end

  it "should return nil values when estimation is nil" do
    t = Factory(:deliverable_type)
    f = Factory(:deliverable)
    f.type = t
    f.save!

    ret = f.historical_data(Factory(:complexity))

    ret[:effort][:min].should == nil
    ret[:effort][:max].should == nil
    ret[:effort][:avg].should == nil

    ret[:size][:min].should == nil
    ret[:size][:max].should == nil
    ret[:size][:avg].should == nil

    ret[:productivity_rate][:min].should == nil
    ret[:productivity_rate][:max].should == nil
    ret[:productivity_rate][:avg].should == nil
  end

  it "should return nil values when complexity is nil" do
    t = Factory(:deliverable_type)
    f = Factory(:deliverable)
    e = Factory(:estimation)
    f.type = t
    f.estimation = e
    f.save!

    ret = f.historical_data(Factory(:complexity))

    ret[:effort][:min].should == nil
    ret[:effort][:max].should == nil
    ret[:effort][:avg].should == nil

    ret[:size][:min].should == nil
    ret[:size][:max].should == nil
    ret[:size][:avg].should == nil

    ret[:productivity_rate][:min].should == nil
    ret[:productivity_rate][:max].should == nil
    ret[:productivity_rate][:avg].should == nil
  end

  describe "historical_data()" do
    before(:each) do
      t = Factory(:deliverable_type)
      @c = Factory(:complexity)

      @c.valid?.should == true
      @c.id.nil?.should == false

      @d1 = Factory(:deliverable, :type => t)
      e = Factory(:estimation, :effort => 5, :size => 20, :productivity_rate => 100,:is_updated=>'t'  )
      @d1.estimation = e
      e.complexity = @c
      @d1.save!
      e.save!

      @d2 = Factory(:deliverable, :type => t)
      e = Factory(:estimation, :effort => 10, :size => 30, :productivity_rate => 100,:is_updated=>'t')
      @d2.estimation = e
      e.complexity = @c
      @d2.save!
      e.save!

      @d3 = Factory(:deliverable, :type => t)
      e = Factory(:estimation, :effort => 15, :size => 40, :productivity_rate => 100,:is_updated=>'t')
      @d3.estimation = e
      e.complexity = @c
      @d3.save!
      e.save!

    end

    it "should exist" do
      @d1.should respond_to(:historical_data)
    end

    it "should return min, max and avg of effort" do
      ret = @d1.historical_data(@c)
      ret[:effort][:min].should == 5
      ret[:effort][:max].should == 15
      ret[:effort][:avg].should == 10
    end

    it "should return min, max and avg of size" do
      ret = @d1.historical_data(@c)
      ret[:size][:min].should == 20
      ret[:size][:max].should == 40
      ret[:size][:avg].should == 30
    end

    it "should return min, max and avg of productivity rate" do
      ret = @d1.historical_data(@c)
      ret[:productivity_rate][:min].should == 100
      ret[:productivity_rate][:max].should == 100
      ret[:productivity_rate][:avg].should == 100
    end
  end

  describe "effort" do

    before (:each) do
      @deliverable_test= Factory :deliverable
      @user_test = Factory :user

      @attrs = {
        :date_of_logging => Date.new(2011,1,1),
        :time_spent => 1.0,
        :interrupt_time => 0.5
      }
    end

    it "should have efforts attribute" do
      new_attrs = @attrs
      new_attrs[:deliverable_id] = @deliverable_test.id
      new_attrs[:user_id] = @user_test.id
      effort = Effort.create!(@attrs)
      @deliverable_test.efforts.should == [effort]
    end

  end

  describe "effort" do
    before (:each) do
     @attr= {
        :name => "Test Deliverable",
        :description => "Test Deliverable Description",
      }

    end

    it "should have is_done attribute and return false" do
      @deliverable_test= Deliverable.create!(@attr)
      @deliverable_test.is_done.should == false
    end
  end

  describe "Deliverables.recent_deliverables()" do
    before do
      @user1 = Factory(:user)
      @user2 = Factory(:user)
      @deliverables = []

      counter = 1

      10.times {
        d = Factory(:deliverable)

        e1 = Factory(:effort, :date_of_logging => DateTime.new(2011, 1, counter))
        e1.owner = @user1
        e1.save!

        e2 = Factory(:effort, :date_of_logging => DateTime.new(2011, 1, counter))
        e2.owner = @user2
        e2.save!

        d.efforts << e1
        d.efforts << e2
        d.save!

        @deliverables << d

        counter += 1
      }
    end

    it "should return a list of 5 recent deliverables" do
      rd = Deliverable.recent_deliverables(@user1.id)

      rd.length.should == 5
      for i in (0..4)
        rd[i].id.should == @deliverables[9 - i].id
      end
    end
  end


  describe "deliverables.logged_efforts()" do
    before do
      @user = Factory(:user)
      @deliverable =Factory(:deliverable)
      @effort1=Factory(:effort, :time_spent => 1,:deliverable_id=>@deliverable.id)
      @effort2=Factory(:effort, :time_spent => 2,:deliverable_id=>@deliverable.id)
    end

    it "should show the logged_efforts" do
      @deliverable.logged_efforts.should == @effort2.time_spent+@effort1.time_spent
    end
  end


  describe "deliverables.lastest_effortlogging_time()" do
    before do
      @user = Factory(:user)
      @deliverable =Factory(:deliverable)
      @effort1=Factory(:effort, :date_of_logging => DateTime.new(2012, 1, 1),:deliverable_id=>@deliverable.id)
      @effort2=Factory(:effort, :date_of_logging => DateTime.new(2011, 2, 1),:deliverable_id=>@deliverable.id)
    end

    it "should show the lasted effort" do
      @deliverable.lastest_effortlogging_time.should == @effort2.date_of_logging
    end
  end


  describe "deliverables.interrupted_hrs()" do
    before do
      @user = Factory(:user)
      @deliverable =Factory(:deliverable)
      @effort1=Factory(:effort, :interrupt_time => 1,:deliverable_id=>@deliverable.id)
      @effort2=Factory(:effort, :interrupt_time => 2,:deliverable_id=>@deliverable.id)
    end

    it "should show the interrupted_hrs" do
      @deliverable.interrupted_hrs.should ==  @effort2.interrupt_time+@effort1.interrupt_time
    end
  end
end

# == Schema Information
#
# Table name: deliverables
#
#  id                  :integer         not null, primary key
#  name                :string(255)
#  description         :string(255)
#  phase_id            :integer
#  created_at          :datetime
#  updated_at          :datetime
#  deliverable_type_id :integer
#

