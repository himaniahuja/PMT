require 'spec_helper'

describe "projects/new.html.erb" do

  before(:each) do
    life_cycle = Factory(:life_cycle)
    project = Factory(:project, :life_cycle => life_cycle)
    life_cycles = LifeCycle.all
    assign :project, project
    assign :lifecycles, life_cycles
    render
  end


  it 'displays a form to create a project' do
      rendered.should have_selector('form',:method => 'post',:action => '/projects') do |form|
          form.should have_selector('input', :type => 'submit')
      end
  end

  it 'displays a field to enter a name' do
    rendered.should have_selector('form',:id => 'name') do |form|
      form.should have_selector('label', :for => 'name')
      form.should have_selector('input', :type => 'text', :name => 'project[name]')
    end
  end

  it "renders new page form" do
    render
    rendered.should have_selector("form", :action => projects_path, :method => "post")
  end

  it 'displays a text area to enter a description' do
    rendered.should have_selector('form',:id => 'description') do |form|
      form.should have_selector('label', :for => 'description')
      form.should have_selector('textarea',:name => 'project[description]')
    end
  end

end



