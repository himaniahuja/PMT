require 'spec_helper'

describe "projects/show.html.erb" do

  describe "Show project page" do
    before(:each) do
      life_cycle = Factory(:life_cycle)

      @project = Factory(:project, :life_cycle => life_cycle)
      @phase = Factory(:phase)
      @owner = Factory(:user)
      @project.phases << @phase

      assign :project, @project
      assign :owner, @owner
      assign :lifecycle, life_cycle
      assign :phases, @project.phases
    end

    it 'should display the show phases name in the show page' do
      render
      rendered.should have_content(@phase.name)
      rendered.should have_content("Phase")
    end

    it 'should show the new phases added' do
      @new_phase = Factory(:phase)
      @project.phases << @new_phase
      render
      rendered.should have_content( @new_phase.name)
      rendered.should have_content("Phase")
    end

    it 'should show the link to user profile' do
      render
      rendered.should have_selector('a',:content=>@owner.username)
    end
  end
end