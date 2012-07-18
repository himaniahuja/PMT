require 'spec_helper'

describe 'projects' do

    before(:each) do
      user = Factory(:user)
      @life_cycle = Factory(:life_cycle)
	  @phase_template = Factory(:phase_template, :life_cycle => @life_cycle)

      visit '/users/sign_in'
      fill_in "Password", :with => user.password
      fill_in "Email", :with => user.email
      click_button "Sign in"

    end

  describe "POST /projects" do

    it "creates project" do
      visit '/'
      click_link 'Create Project'

      page.should have_selector('input#project_name')
      page.should have_selector('textarea#project_description')
      page.should have_selector('input#project_submit')
      page.should have_selector("input#project_start_date")
      page.should have_selector("input#project_estimated_end_date")
      page.should have_selector("input#project_is_finished")

      fill_in "Name", :with => "Example Project"
      fill_in "Description", :with => "Example Project description"
      page.select(@life_cycle.name, :from => "project_life_cycle_id")
      click_button "Add Project"
      # save_and_open_page
      page.should have_content("Successfully created the Project.")
      page.should have_content("Example Project")
      page.should have_content("Example Project description")

    end

  end


  describe "Test the Edit page" do

    before(:each) do
      @project = Factory(:project, :life_cycle => @life_cycle)
	  @phase = Factory(:phase)
      @owner = Factory(:user)
      @project.phases << @phase
    end

    it "show update page" do
      visit project_path(@project)
      click_link 'Edit'

      page.should have_content("Update the Project")
    end

    it "should show editable fields" do
      visit edit_project_path(@project)
      page.should have_selector('input#project_name')
      page.should have_selector('textarea#project_description')
      page.should have_selector('input#project_submit')

      page.should have_selector("input#project_start_date")
      page.should have_selector("input#project_estimated_end_date")
      page.should have_selector("input#project_is_finished")
    end

    it "should update the project" do
      visit edit_project_path(@project)

      fill_in "Name", :with => "Example updated"
      fill_in "Description", :with => "Example Project description updated"
      click_button "Apply"

      Project.where("name = 'Example updated' AND description = 'Example Project description updated'").count.should == 1
    end

    it "should show updated project" do
      visit edit_project_path(@project)
      fill_in "Name", :with => "Example updated"
      fill_in "Description", :with => "Example Project description updated"
      click_button "Apply"

      #show
      page.should have_selector('p',:content => 'Project was successfully updated.')
      page.should have_content("Example updated")
      page.should have_content("Example Project description updated")
      page.should have_content("Start Date")
      page.should have_content("Estimated End Date")
      page.should have_content("Finished")
    end

  end

  describe "Test the Show page" do
    before(:each) do
      @project = Factory(:project, :life_cycle => @life_cycle)
      @phase = Factory(:phase)
      @project.phases << @phase
    end

    it 'should display the show phases name in the show page' do
      visit project_path(@project)
      @project.phases.each do |p|
        page.should have_content(p.name)
        page.should have_content("Phase")
		page.should have_content("effort")
      end

    end

  end

end