# == Schema Information
#
# Table name: deliverables
#
#  id                  :integer         not null, primary key
#  name                :string(255)
#  description         :string(255)
#  phase_id            :integer
#  created_at          :datetime
#  updated_at          :datetime
#  deliverable_type_id :integer
#  is_done             :boolean         default(FALSE)
#
#
#
class Deliverable < ActiveRecord::Base
  belongs_to :phase
  has_many :efforts
  belongs_to :type, :foreign_key => "deliverable_type_id", :class_name => "DeliverableType"
  has_one :estimation,:foreign_key => "deliverable_id"

  validates :name, :presence => true, :length => { :within => 2..60 }

  after_save :new_estimation
  accepts_nested_attributes_for :estimation
  accepts_nested_attributes_for :type

  # Return the maximum, minimum and average of size, effort and productivity
  # rate of deliverables with the same type and complexity
  #
  # To access the maximal size, res[:size][:max] can be used

  def historical_data(cpx)
    if self.type.nil?
      sql_entry = [nil, nil, nil, nil, nil, nil]
    else
      #sql_result = ActiveRecord::Base.connection.execute("SELECT MAX(e.size), MIN(e.size), AVG(e.size), MAX(e.effort), MIN(e.effort), AVG(e.effort), MAX(e.productivity_rate), MIN(e.productivity_rate), AVG(e.productivity_rate) FROM deliverables AS d INNER JOIN estimations AS e ON e.deliverable_id = d.id WHERE d.deliverable_type_id = #{self.deliverable_type_id} AND e.complexity_id = #{self.estimation.complexity_id}")
      sql_result = ActiveRecord::Base.connection.execute("SELECT MAX(e.size), MIN(e.size), AVG(e.size), MAX(e.effort), MIN(e.effort), AVG(e.effort), MAX(e.productivity_rate), MIN(e.productivity_rate), AVG(e.productivity_rate) FROM deliverables AS d INNER JOIN estimations AS e ON e.deliverable_id = d.id WHERE d.deliverable_type_id = #{self.deliverable_type_id} AND e.complexity_id = #{cpx.id} AND e.is_updated = 't' ")
      sql_entry = sql_result[0]
    end
    res = {}
    res[:size] = {:max => sql_entry[0], :min => sql_entry[1], :avg => sql_entry[2]}
    res[:effort] = {:max => sql_entry[3], :min => sql_entry[4], :avg => sql_entry[5]}
    res[:productivity_rate] = {:max => sql_entry[6], :min => sql_entry[7], :avg => sql_entry[8]}

    return res
  end

  # Return a list of deliverables the given user worked on recently

  def self.recent_deliverables(uid, limit = 5)
    if uid.nil?
      return []
    else
     return Deliverable.find_by_sql("SELECT distinct deliverables.* , efforts.created_at as effort_order FROM  deliverables INNER JOIN efforts ON efforts.deliverable_id = deliverables.id WHERE efforts.user_id = #{uid} AND deliverables.is_done = 'f' ORDER BY effort_order DESC Limit 5")
    end
  end

  def lastest_effortlogging_time
    self.efforts.order('created_at DESC').first.date_of_logging
  end

  def logged_efforts
    sum = 0.0
    self.efforts.each do |e|
      sum += e.time_spent
    end
    return sum
  end

  def interrupted_hrs
    sum = 0.0
    self.efforts.each do |e|
      sum += e.interrupt_time
    end
    return sum
  end

  private

  def new_estimation
    Estimation.create!(:deliverable_id=>self.id)
  end
end

