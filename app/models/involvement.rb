# == This class defines the relationships between users and projects
# == Schema Information
#
# Table name: involvements
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  project_id :integer
#  created_at :datetime
#  updated_at :datetime
#
#
#
#
class Involvement < ActiveRecord::Base
  default_scope :include => :project, :conditions => {:projects => {:is_archived => false}}

  attr_accessible :user_id ,:project_id
  validates_uniqueness_of :user_id, :scope => :project_id

  belongs_to :user, :class_name => "User"
  belongs_to :project, :class_name => "Project"

  validates :user_id, :presence => true
  validates :project_id, :presence => true

  def self.delete_involvement(project, user)
    unscoped.delete_all(["project_id = ? AND user_id = ?", project.id, user.id])
  end
end

