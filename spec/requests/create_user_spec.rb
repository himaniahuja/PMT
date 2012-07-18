require 'spec_helper'
require "rspec"

describe 'CreateUser' do

  context "anonymous users" do

    it "should be reject from the sign-up page"   do
      visit '/users/sign_up'
      page.html.should match /sign in/
    end

  end

  context "signed-in users" do

    before(:each) do
      @signed_in = Factory(:user)
      visit '/users/sign_in'
      fill_in "Email", :with => @signed_in.email
      fill_in "Password", :with => @signed_in.password
      click_button "Sign in"
    end

    it "The create user page should exist" do

      visit '/users/sign_up'
      page.should have_selector('input#user_username')
      page.should have_selector('input#user_password')
      page.should have_selector('input#user_email')
      page.should have_selector('input#user_password_confirmation')
      page.should have_selector('input#user_submit')
    end

    it "a user object should be created in the database after the create user form is submitted" do

      user=Factory.build(:user)
      visit '/users/sign_up'
      fill_in "Username", :with => user.username
      fill_in "Password", :with => user.password
      fill_in "Password confirmation", :with => user.password
      fill_in "Email", :with => user.email
      click_button 'Create User'
      User.where("username= ? AND email = ?", user.username, user.email).count.should == 1
      page.should_not have_content(user.username)
      page.should have_content(@signed_in.username)
    end
  end


end
