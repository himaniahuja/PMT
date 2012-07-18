# == Schema Information
#
# Table name: phase_templates
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  description   :string(255)
#  life_cycle_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#


class PhaseTemplate < ActiveRecord::Base
  belongs_to :life_cycle
  has_many :deliverable_templates

  validates :name, :presence => true, :length => { :within => 2..60 }
end
