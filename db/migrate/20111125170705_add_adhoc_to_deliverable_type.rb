class AddAdhocToDeliverableType < ActiveRecord::Migration
  def self.up
    add_column :deliverable_types, :adhoc, :boolean
  end

  def self.down
    remove_column :deliverable_types, :adhoc
  end
end
