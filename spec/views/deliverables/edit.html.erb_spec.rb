require 'spec_helper'

describe "deliverables/edit.html.erb" do

  before(:each) do

	@phase = Factory(:phase)
    @deliverable = Factory(:deliverable, :phase_id => @phase.id)
	@phase.deliverables << @deliverable
	deliverable_types  = DeliverableType.all
	assign :deliverable, @deliverable
	assign :deliverable_types, deliverable_types
    render
  end


  it 'displays a form to edit a deliverable' do
      rendered.should have_selector('form',:method => 'post',:action => "/deliverables/#{@deliverable.id}") do |form|
          form.should have_selector('input', :type => 'submit')
      end
  end

  it 'displays a field to edit a name' do
    rendered.should have_selector('form',:id => 'name') do |form|
      form.should have_selector('label', :for => 'name')
      form.should have_selector('input', :type => 'text', :name => 'deliverable[name]')
    end
  end

  it "renders edit page form" do
    render
    rendered.should have_selector("form", :action => deliverables_path, :method => "post")
  end

  it 'displays a text area to enter a description' do
    rendered.should have_selector('form',:id => 'description') do |form|
      form.should have_selector('label', :for => 'description')
      form.should have_selector('textarea',:name => 'deliverable[description]')
    end
  end

end
