require 'spec_helper'

describe 'UserProfile' do
    before(:each) do
      user = Factory(:user)

      visit '/users/sign_in'
      fill_in "Password", :with => user.password
      fill_in "Email", :with => user.email
      click_button "Sign in"

      @user= Factory(:user)
      projects=(1..3).map{Factory(:project)}
      projects.stub!(:total_pages).and_return(1)
      projects.each do |p|
        Involvement.create!(:user_id=>@user.id,:project_id=>p.id)
      end

    end

    it "should show the user info" do
      visit profile_path(@user.id)

      page.should have_content(@user.username)
      page.should have_content(@user.email)
    end

    it "should show the user projects" do
      visit profile_path(@user.id)
      @user.projects.each do |p|
       page.should have_content(p.name)
       page.should have_content(p.description)
     end
    end
end
