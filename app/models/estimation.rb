# == Schema Information
#
# Table name: estimations
#
#  id                :integer         not null, primary key
#  productivity_rate :float
#  effort            :float
#  size              :float
#  deliverable_id    :integer
#  complexity_id     :integer
#  created_at        :datetime
#  updated_at        :datetime
#
#
#
#
 class Estimation < ActiveRecord::Base
  belongs_to :deliverable
  belongs_to :complexity

   accepts_nested_attributes_for :deliverable
end
