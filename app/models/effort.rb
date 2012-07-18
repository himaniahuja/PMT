
# == Schema Information
#
# Table name: efforts
#
#  id              :integer         not null, primary key
#  user_id         :integer
#  deliverable_id  :integer
#  created_at      :datetime
#  updated_at      :datetime
#  date_of_logging :datetime
#  time_spent      :float
#  interrupt_time  :float
#

class Effort < ActiveRecord::Base
  belongs_to :owner, :foreign_key => "user_id", :class_name => "User"
  belongs_to :deliverable

  validates :date_of_logging, :presence => true
  validates :time_spent, :presence => true
  validates :interrupt_time, :presence => true
end
