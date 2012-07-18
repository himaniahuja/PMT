
# == Schema Information
#
# Table name: life_cycles
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#
class LifeCycle < ActiveRecord::Base
  has_many :phase_templates
  has_many :projects

  validates :name, :presence => true, :length => { :within => 2..40 }
end

