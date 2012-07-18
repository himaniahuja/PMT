
# == Schema Information
#
# Table name: deliverable_templates
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  description       :text
#  phase_template_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#  type_id           :integer
#
#
#
#
class DeliverableTemplate < ActiveRecord::Base

  belongs_to :phase_template
  belongs_to :deliverable_type, :foreign_key => "type_id"
  validates :name, :presence => true, :length => { :within => 2..60 }

end
