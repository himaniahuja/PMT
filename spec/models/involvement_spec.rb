require 'spec_helper'

describe Involvement do

  before(:each) do
    @user = Factory(:user)
    @user2 = Factory(:user)

    @project = Factory(:project)
    @project2 = Factory(:project)

    @involvement = @user.involvements.build(:project_id => @project.id)
  end

  it "should have the project attribute" do
    @involvement.should respond_to :project
  end

  it "should have the user attribute" do
    @involvement.should respond_to :user
  end

  it "should create an instance of involvement with valid attributes" do
    Involvement.create!(:user_id => @user.id,:project_id =>@project.id)
    @inv= Involvement.new(:user_id => @user2.id,:project_id =>@project2.id)
    @inv.should be_valid
  end

  it "should be fail if the user_id is missed" do
    @involvement.user_id = nil
    @involvement.should_not be_valid
  end

  it "should be fail if the project_id is missed" do
    @involvement.project_id = nil
    @involvement.should_not be_valid
  end

  it "should be unique" do
    Involvement.create!(:user_id => @user.id,:project_id =>@project.id)
    @inv= Involvement.new(:user_id => @user.id,:project_id =>@project.id)
    @inv.should_not be_valid
  end

  it "one project can have many users" do
    Involvement.create!(:user_id => @user.id,:project_id =>@project.id)
    @inv= Involvement.new(:user_id => @user2.id,:project_id =>@project.id)
    @inv.should be_valid
  end

  it "one user could participate in many projects" do
    Involvement.create!(:user_id => @user.id,:project_id =>@project.id)
    @inv= Involvement.new(:user_id => @user.id,:project_id =>@project2.id)
    @inv.should be_valid
  end

  it "when the project is deleted, all the involve related to this project should be deleted" do
     pending "Not implemented"
  end

end

# == Schema Information
#
# Table name: involvements
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  project_id :integer
#  created_at :datetime
#  updated_at :datetime
#

