class CreatePhaseTemplates < ActiveRecord::Migration
  def self.up
    create_table :phase_templates do |t|
      t.string :name
      t.string :description
      t.integer :life_cycle_id

      t.timestamps
    end
  end

  def self.down
    drop_table :phase_templates
  end
end
