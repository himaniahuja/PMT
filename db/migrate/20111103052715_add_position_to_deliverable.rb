class AddPositionToDeliverable < ActiveRecord::Migration
  def self.up
    add_column :deliverables, :position, :integer
  end

  def self.down
    remove_column :deliverables, :position
  end
end
