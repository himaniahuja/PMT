require "spec_helper"

describe "estimations/edit.html.erb" do
context "Should have essential elements" do
    before(:each) do
       deliverable_type = Factory(:deliverable_type)
       complexity = Factory(:complexity)

       @deliverable = Factory(:deliverable, :type => deliverable_type)
       estimation = Factory(:estimation, :effort => 5, :size => 20, :productivity_rate => 100)
       @deliverable.estimation = estimation
       estimation.complexity = complexity
       @deliverable.save!
       estimation.save!

       assign :estimation, estimation
       assign :complexities, [complexity]
     end


    it "should have Title" do
      render
      rendered.should have_selector("h1",:content=>"Estimate Deliverable")
    end

    it 'displays a form to create an estimation' do
      render
      rendered.should have_selector('form',:method => 'post',:action => '/estimations') do |form|
          form.should have_selector('input', :type => 'submit')
      end
    end

    it 'displays a field to enter size ' do
      render
      rendered.should have_selector('form',:id => 'new_estimation') do |form|
        form.should have_selector('label', :for => 'size')
        form.should have_selector('input', :type => 'text', :name => 'estimation[size]')
      end
    end

    it 'displays a field to enter effort ' do
      render
      rendered.should have_selector('form',:id => 'new_estimation') do |form|
        form.should have_selector('label', :for => 'effort')
        form.should have_selector('input', :type => 'text', :name => 'estimation[effort]')
      end
    end

    it 'displays a field to enter productivity_rate ' do
      render
      rendered.should have_selector('form',:id => 'new_estimation') do |form|
        form.should have_selector('label', :for => 'productivity_rate')
        form.should have_selector('input', :type => 'double', :name => 'estimation[productivity_rate]')
      end
    end

    it 'should have a drop down to show the complexity dropdown' do
      render
      rendered.should have_selector('form',:id => 'new_estimation') do |form|
        form.should have_selector('label', :for => 'complexity')
        form.should have_selector('select', :name => 'estimation[complexity]')
        @complexities.each do |c|
           form.should have_selector('select', :value => c.name)
        end
      end
    end


  end

end