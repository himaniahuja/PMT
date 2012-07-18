class AddUnitToDeliverableType < ActiveRecord::Migration
  def self.up
    add_column :deliverable_types, :unit_id, :integer
  end

  def self.down
    remove_column :deliverable_types, :unit_id, :integer
  end
end
