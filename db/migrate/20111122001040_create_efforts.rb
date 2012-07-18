class CreateEfforts < ActiveRecord::Migration
  def self.up
    create_table :efforts do |t|
      t.integer :user_id
      t.integer  :deliverable_id
      t.timestamps
    end
  end

  def self.down
    drop_table :efforts
  end
end
