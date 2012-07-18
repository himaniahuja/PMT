
# == Schema Information
#
# Table name: deliverable_types
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  unit_id     :integer
#  adhoc       :boolean
#
#
class DeliverableType < ActiveRecord::Base
  validates :name, :presence => true
  has_many :deliverable
  belongs_to :unit
  has_many :deliverable_templates

  accepts_nested_attributes_for :deliverable

  def self.find_types
	find(:all, :conditions => {:adhoc => false}, :order => "name")
  end

end
