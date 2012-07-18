class RemovePositionToFromDeliverables < ActiveRecord::Migration
  def self.up
    remove_column :deliverables, :position
  end

  def self.down
    add_column :deliverables, :position, :integer
  end
end
