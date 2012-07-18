class AddLifecycleToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :life_cycle_id, :integer
  end

  def self.down
    remove_column :projects, :life_cycle_id
  end
end
