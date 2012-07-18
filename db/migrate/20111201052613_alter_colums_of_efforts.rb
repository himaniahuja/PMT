class AlterColumsOfEfforts < ActiveRecord::Migration
  def self.up
    change_column :efforts, :date_of_logging, :date
  end

  def self.down
    change_column :efforts, :date_of_logging, :datetime
  end
end
