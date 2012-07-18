# == Schema Information
#
# Table name: phases
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  project_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#  position    :integer
#
# == This class defines the phases of a project
class Phase < ActiveRecord::Base
  has_many :deliverables
  belongs_to :project

  validates :name, :presence => true, :length => { :within => 2..60 }
  accepts_nested_attributes_for :deliverables,:reject_if => lambda {|a| a[:name].blank?}, :allow_destroy => true

  def estimated_efforts
    sum = 0.0
    self.deliverables.each do |d|
      sum += d.estimation.effort unless d.estimation.nil?||d.estimation.effort.nil?
    end
    return sum
  end

end

