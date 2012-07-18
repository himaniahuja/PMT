# == Schema Information
#
# Table name: projects
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  description        :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  start_date         :date
#  estimated_end_date :date
#  is_finished        :boolean
#  owner              :integer
#  life_cycle_id      :integer
#  is_archived        :boolean
#

class Project < ActiveRecord::Base
  has_many :phases, :dependent => :destroy, :order => "position ASC"
  belongs_to :life_cycle
  belongs_to :user, :foreign_key => :owner

  has_many :involvements, :foreign_key => :project_id,
                          :dependent => :destroy
  has_many :users, :through => :involvements,
                    :source => :user

  validates :name, :presence => true, :length => { :within => 2..60 }

  accepts_nested_attributes_for :phases, :allow_destroy => true, :reject_if => lambda {|a| a[:name].blank?}

  def self.unarchived
    return where(:is_archived => false)
  end

  def self.archived
    return where(:is_archived => true)
  end

  def self.archived_and_unarchived
    return unscoped
  end

  def self.on_going
    return where({:is_archived => false, :is_finished => false})
  end

  def self.find_user_related(uid)
    return joins(:involvements).where(:involvements => {:user_id => uid})
  end

  def can_toggle_archive
    return is_archived || is_finished
  end

  def can_edit
    return !is_finished
  end

  def is_ongoing
    return !is_archived && !is_finished
  end

  def update_members(members)
	 all_invalid_names = []
	 owner_id = self.owner
	 if !owner_id.nil?
	  owner = User.find(owner_id)
	 else
	  owner = current_user
	 end

	# self.users = []
	 return "" if members.nil?
	 members.delete("")

	 msg = ""
	 members.each do |name|
	   person = User.find_by_username(name)
	   if person.nil?
		# all_valid_names = false
		   msg = msg + "'" + name + "' is not in the database. "
		   self.errors.add(:username, "Person " + name + " not found")
	   elsif person.id == owner.id
		 #all_valid_names = false
		   msg = msg + "'" + name + "' is already on the project"
		   self.errors.add(:username, "Person " + name + " is already on project")
	   else
       if !self.users.nil?
         self.users.each do |u|
           if person.id == u.id
             all_invalid_names << person.username
           end
         end
         if !all_invalid_names.empty?
           msg = msg + "'" + name + "' is already on the project"
           self.errors.add(:username, "Person " + name + " is already on project")
         else
           self.users << person
         end
       end
	   end
	 end
	 return msg
  end

  def estimated_efforts
    sum = 0.0
    self.phases.each do |p|
      p.deliverables.each do |d|
          sum += d.estimation.effort unless d.estimation.nil?||d.estimation.effort.nil?
      end
    end
    return sum
  end

  def self.search(search)
      where('name LIKE ?', "%#{search}%")
  end

end

