
# == Schema Information
#
# Table name: complexities
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#
#
class Complexity < ActiveRecord::Base
  has_many :estimations
  validates :name, :presence => true, :length => { :within => 2..16 }
end
