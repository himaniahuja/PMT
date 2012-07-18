require 'spec_helper'

describe 'pages' do

  context 'showall page' do
    before(:each) do

      visit '/users/sign_in'
      user = Factory(:user)
      fill_in "Password", :with => user.password
      fill_in "Email", :with => user.email
      click_button "Sign in"

      life_cycle = Factory(:life_cycle)
      @projects=(1..3).map{Factory(:project,:life_cycle => life_cycle)}
      @projects.stub!(:total_pages).and_return(1)
    end

    it "should show the tables" do
      visit pages_showall_path(@projects)

      page.should have_selector('table#showallTable')
      page.should have_selector('th.header')
    end

    it "should link to projects" do
      @projects.each do |p|
        visit pages_showall_path(@projects)

        click_link p.name
        page.should have_content(p.name)
        page.should have_content(p.description)
        page.should have_content(p.life_cycle.name)
      end

    end
  end

  context 'showmy page' do
    before(:each) do

      visit '/users/sign_in'
      user = Factory(:user)
      fill_in "Password", :with => user.password
      fill_in "Email", :with => user.email
      click_button "Sign in"

      life_cycle = Factory(:life_cycle)
      @projects=(1..3).map{Factory(:project,:life_cycle => life_cycle)}
      @projects.stub!(:total_pages).and_return(1)
      @projects.each do |p|
        p.involvements.create!(:user_id=>user.id)
      end
    end

    it "should show the tables" do
      visit pages_showmy_path(@projects)

      page.should have_selector('table#showallTable')
      page.should have_selector('th.header')
    end

    it "should link to my projects" do
      @projects.each do |p|
        visit pages_showmy_path(@projects)

        click_link p.name
        page.should have_content(p.name)
        page.should have_content(p.description)
        page.should have_content(p.life_cycle.name)
      end

    end
  end

  context 'search projects' do
    before(:each) do

      visit '/users/sign_in'
      user = Factory(:user)
      fill_in "Password", :with => user.password
      fill_in "Email", :with => user.email
      click_button "Sign in"

      life_cycle = Factory(:life_cycle)
      @projects=(1..3).map{Factory(:project,:life_cycle => life_cycle)}
      @projects.stub!(:total_pages).and_return(1)
    end

    it "should show search box" do
      visit pages_showall_path(@projects)

      have_selector('input#search_project')
      page.should have_selector('table#showallTable')
      page.should have_selector('th.header')
    end

    it "should show search results" do
      @projects.each do |p|
        visit pages_showall_path([])

        fill_in 'search_project',:with => p.name

        page.should have_content(p.name)
      end

    end
  end
end