class AddAttributesToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :start_date, :date
    add_column :projects, :estimated_end_date, :date
    add_column :projects, :is_finished, :boolean
  end

  def self.down
    remove_column :projects, :is_finished
    remove_column :projects, :estimated_end_date
    remove_column :projects, :start_date
  end
end
