class CreateDeliverables < ActiveRecord::Migration
  def self.up
    create_table :deliverables do |t|
      t.string :name
      t.string :description
      t.integer :phase_id

      t.timestamps
    end
  end

  def self.down
    drop_table :deliverables
  end
end
