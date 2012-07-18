class RemoveUnitFromEstimation < ActiveRecord::Migration
  def self.up
    remove_column :estimations, :unit_id
  end

  def self.down
    add_column :estimations, :unit_id, :integer
  end
end
