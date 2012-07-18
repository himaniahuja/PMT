require 'spec_helper'

describe 'UserSignIn' do

  it "user can sign in" do
    user = Factory(:user)
    visit '/users/sign_in'
    fill_in "Password", :with => user.password
    fill_in "Email", :with => user.email
    click_button "Sign in"
    page.has_content?('Welcome').should eq(true)
    current_path.should eq('/')
  end


  it "rejects invalid users" do

    visit '/users/sign_in'
    fill_in "Password", :with => ' '
    fill_in "Email", :with => ' '
    click_button "Sign in"
    page.has_content?('Please sign in to continue').should eq(true)

  end

end