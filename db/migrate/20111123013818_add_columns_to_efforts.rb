class AddColumnsToEfforts < ActiveRecord::Migration
  def self.up
    add_column :efforts, :date_of_logging, :datetime
    add_column :efforts, :time_spent, :float
    add_column :efforts, :interrupt_time, :float
  end

  def self.down
    remove_column :efforts, :interrupt_time
    remove_column :efforts, :time_spent
    remove_column :efforts, :date_of_logging
  end
end
