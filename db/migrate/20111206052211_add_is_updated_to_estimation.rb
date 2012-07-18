class AddIsUpdatedToEstimation < ActiveRecord::Migration
  def self.up
    add_column :estimations, :is_updated, :boolean ,:default => false
  end

  def self.down
    remove_column :estimations, :is_updated, :boolean
  end
end
