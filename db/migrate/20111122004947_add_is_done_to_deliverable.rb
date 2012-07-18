class AddIsDoneToDeliverable < ActiveRecord::Migration
  def self.up
    add_column :deliverables, :is_done, :boolean,:default => false
  end

  def self.down
    remove_column :deliverables, :is_done
  end
end
