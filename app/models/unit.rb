# == Schema Information
#
# Table name: units
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#
#
#  == Design Change:
#
#  At the beginning of iteration 2, we designed that each estimation has one kind of Unit. However,
#  Units should be related to the deliverable type rather than estimation. Thus, we remove the association between Unit
#  and Estimation, create a new one between Unit and DeliverableType
#
#
#
class Unit < ActiveRecord::Base
    #has_many :estimations
  has_many :deliverable_types
  validates :name, :presence => true, :length => { :within => 2..16 }
end

