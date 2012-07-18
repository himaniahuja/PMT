class AddIsArchivedToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :is_archived, :boolean
  end

  def self.down
    remove_column :projects, :is_archived
  end
end
