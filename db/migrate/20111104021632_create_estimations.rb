class CreateEstimations < ActiveRecord::Migration
  def self.up
    create_table :estimations do |t|
      t.float :productivity_rate
      t.float :effort
      t.float :size
      t.integer :deliverable_id
      t.integer :complexity_id
      t.integer :unit_id
      t.timestamps
    end
  end

  def self.down
    drop_table :estimations
  end
end
