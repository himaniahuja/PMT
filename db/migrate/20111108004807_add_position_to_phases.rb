class AddPositionToPhases < ActiveRecord::Migration
  def self.up
    add_column :phases, :position, :integer
  end

  def self.down
    remove_column :phases, :position
  end
end
