FactoryGirl.define do

 sequence :email do |n|
   "email#{n}@example.com"
 end

 sequence :username do |n|
   "username#{n}"
 end

 factory :user do
   email { Factory.next(:email) }
   password "secret"
   password_confirmation "secret"
   username { Factory.next(:username) }
   role "admin"
 end

 sequence :life_cycle_name do |n|
   "lc_#{n}"
 end

 factory :life_cycle do
   name { Factory.next(:life_cycle_name) }
   description "test description"
 end

 sequence :project_name do |n|
   "test_project#{n}"
 end

 factory :project do |p|
   p.name {Factory.next(:project_name)}
   p.description { "test description" }
   p.owner { 1 }
   p.is_finished { 'false' }
   p.is_archived false
   p.after_create { |a|
     if (a.life_cycle_id.nil?)
       a.life_cycle = Factory(:life_cycle)
     end
   }
 end

 Factory.define :project_with_involvements, :parent => :project do |p|
   p.involvements { |project| [ project.association(:involvement, :project_id => p.id), project.association(:involvement, :project_id => p.id) ] }
 end

 sequence :phase_name do |n|
   "test_phase#{n}"
 end

  Factory.define :phase do |p|
    p.name {Factory.next(:phase_name)}
    p.position 0
    p.description "test_phase description"
  end

  Factory.define :phase_template do |t|
	 t.name "Temp1"
	 t.description " Temp1 Desc"
  end

  Factory.define :deliverable do |d|
	  d.name "Doc1"
  end

  Factory.define :phase_with_project, :parent => :phase do |p|
    p.association :project, :factory => :project
  end

  Factory.define :deliverable_with_phase_and_project, :parent => :deliverable do |d|
    d.association :phase, :factory => :phase_with_project
  end

  factory :deliverable_type do
    name "Deliverable Type 1"
  end

 sequence :complexity_name do |n|
    "complexity#{n}"
 end

  factory :complexity do
    name  {Factory.next(:complexity_name)}
    description  {Factory.next(:complexity_name)+"description"}
  end

   sequence :unit_name do |n|
    "unit#{n}"
 end

  factory :unit do
    name  {Factory.next(:unit_name)}
    description  {Factory.next(:unit_name)+"description"}
  end

 sequence :productivity_rate do |n|
    "#{n}"
	end

 sequence :effort do |n|
    "#{n}"
	end

 sequence :size do |n|
    "#{n}"
 end

  factory :estimation do
    productivity_rate Factory.next(:productivity_rate)
    effort Factory.next(:effort)
    size  Factory.next(:size)
  end

  Factory.define :effort do |f|
    f.date_of_logging Date.new(2011,1,1)
    f.time_spent 1.0
    f.interrupt_time 0.5
  end

  Factory.define :involvement do |f|
    f.association :user, :factory => :user
  end

end

