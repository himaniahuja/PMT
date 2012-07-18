class AddTypeToDeliverable < ActiveRecord::Migration
  def self.up
    add_column :deliverables, :deliverable_type_id, :integer
  end

  def self.down
    remove_column :deliverables, :deliverable_type_id
  end
end
