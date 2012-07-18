require "spec_helper"
require 'will_paginate'
describe "pages/showall.html.erb" do

  describe "Test the Show page" do

    before(:each) do
	  user = Factory(:user)
      sign_in user
      @projects=(1..3).map{Factory(:project)}
      @projects.stub!(:total_pages).and_return(1)
      assigns[:projects] = @projects
      render
    end

    it "should render partial _project.html.erb" do
      rendered.should render_template(:partial => '_project')
    end

    it "should show project names" do
     @projects.each do |p|
       rendered.should have_content(p.name)
     end
    end

    it "should show delete links" do
      @projects.each do |p|
        rendered.should have_selector("a[@href=\"/projects/#{p.id}\"][@data-method=\"delete\"]")
      end
    end

  end

  context "Search Project" do
    before(:each) do
	  user = Factory(:user)
      sign_in user
      @projects=(1..3).map{Factory(:project)}
      @projects.stub!(:total_pages).and_return(1)
      assigns[:projects] = @projects
      render
    end

    it "should have search box" do
      rendered.should have_selector('input',:content=>'search_project')
    end
  end
  end
