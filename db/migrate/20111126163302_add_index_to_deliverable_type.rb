class AddIndexToDeliverableType < ActiveRecord::Migration
  def self.up
	 add_index :deliverable_types, :adhoc
  end

  def self.down
	remove_index :deliverable_types, :column => :adhoc
  end
end
