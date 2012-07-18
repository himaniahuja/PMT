require "rspec"

describe User do

  before(:each) do
    @user_attr = Factory.attributes_for(:user)
    @user = Factory(:user)
  end

  it "should create an instance of user with valid attributes" do
    User.create!(@user_attr)
  end

   it "can be saved successfully" do
    User.create.should be_new_record
  end

  context "name" do

    it "has to be present" do
      user = User.new(@user)
      user.respond_to?(:username).should == true
    end

    it "should reject names that are too long" do
      long_name = "a" * 31
      long_name_user = User.new(@user_attr.merge(:username => long_name))
      long_name_user.should_not be_valid
    end


     it "should reject names that are too short" do
      short_username = 'r'
      short_username_user = User.new(@user_attr.merge(:username => short_username))
      short_username_user.should_not be_valid
    end

  end

  context "role" do

    it "has to be present" do
      user = User.new(@user)
      user.respond_to?(:role).should == true
    end

  end

  context "effort" do

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
      new_attr = @attrs
      new_attr[:deliverable_id] = @deliverable_test.id
      new_attr[:user_id] = @user_test.id

      effort = Effort.create!(new_attr)
      @user_test.efforts.should == [effort]
    end

  end

end




# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  username               :string(255)
#  role                   :string(255)
#

