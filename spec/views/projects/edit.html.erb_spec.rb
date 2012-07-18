require 'spec_helper'

describe "projects/edit.html.erb" do

  before(:each) do
    project = Factory(:project)
    assign :project, project
    render
  end


  it 'displays a form to edit the project' do
      rendered.should have_selector('form',:method => 'post',:action => '/projects') do |form|
          form.should have_selector('input', :type => 'submit')
      end
  end

  it 'displays a field to enter new name' do
    rendered.should have_selector('form',:id => 'name') do |form|
      form.should have_selector('label', :for => 'name')
      form.should have_selector('input', :type => 'text', :name => 'project[name]')
    end
  end

  it "renders edit page form" do
    render
    rendered.should have_selector("form", :action => projects_path, :method => "post")
  end

  it 'displays a text area to enter the new description' do
    rendered.should have_selector('form',:id => 'description') do |form|
      form.should have_selector('label', :for => 'description')
      form.should have_selector('textarea',:name => 'project[description]')
    end
  end

end



