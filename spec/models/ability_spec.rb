require "rspec"
require "cancan/matchers"

describe Ability do

  before(:each) do
    @user_attr = Factory.attributes_for(:user)
    @user = Factory(:user)
  end

  it "should let the admin manage any project" do

    @user.role = "admin"
    ability = Ability.new(@user)
    ability.should be_able_to(:manage, Project.new)

  end

  it "should let the admin manage any user" do

    @user.role = "admin"
    ability = Ability.new(@user)
    ability.should be_able_to(:manage, User.new)

  end

  it "should let the manager add a project" do

    @user.role = "manager"
    ability = Ability.new(@user)
    ability.should be_able_to(:create, Project.new)

  end

  it "should let the manager view any project" do

    @user.role = "manager"
    ability = Ability.new(@user)
    ability.should be_able_to(:show, Project.new)

  end


  it "should let the manager update his project" do

    @user.role = "manager"
    @project = Factory(:project)
    @project.owner = @user.id
    ability = Ability.new(@user)
    ability.should be_able_to(:update, @project)

  end

   it "should not let the manager update someone else's project" do

    @user.role = "manager"
    @project = Factory(:project)
    @project.owner = 1000
    ability = Ability.new(@user)
    ability.should_not be_able_to(:update, @project)

   end

  it "should not let the manager delete a project" do

    @user.role = "manager"
    ability = Ability.new(@user)
    ability.should_not be_able_to(:destroy, Project.new)

  end

  it "should let the manager add a user" do

    @user.role = "manager"
    ability = Ability.new(@user)
    ability.should be_able_to(:create, User.new)

  end

  it "should let the developer view any project" do

    @user.role = "developer"
    ability = Ability.new(@user)
    ability.should be_able_to(:show, Project.new)

  end

   it "should not let the developer add/update/delete a user" do

    @user.role = "developer"
    ability = Ability.new(@user)
    ability.should_not be_able_to(:create, User.new)
    ability.should_not be_able_to(:update, User.new)
    ability.should_not be_able_to(:destroy, User.new)

  end

end