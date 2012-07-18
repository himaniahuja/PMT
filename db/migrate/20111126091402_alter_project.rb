class AlterProject < ActiveRecord::Migration
  def self.up
    change_column :projects, :is_archived, :boolean ,:default => false
  end

  def self.down
    change_column :projects, :is_archived, :boolean
  end
end
