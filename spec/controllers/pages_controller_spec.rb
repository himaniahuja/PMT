require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    user = Factory(:user)
    sign_in user

  end

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
  end

  describe "for showall page" do
     it "Get 'showall'" do
        get 'showall'
        response.should be_success
      end
  end

   describe "Get 'showmy'" do
     it "should be successful" do
        get 'showmy'
        response.should be_success
      end
  end

  describe "for search project" do

    it "Post 'search_update'" do
        project = Factory(:project)
        project.name = 'Aurora'
        project.save
        post 'search_update', :search => 'Aurora'
        should render_template
      end
  end

end
