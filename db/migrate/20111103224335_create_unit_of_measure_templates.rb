class CreateUnitOfMeasureTemplates < ActiveRecord::Migration
  def self.up
    create_table :unit_of_measure_templates do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :unit_of_measure_templates
  end
end
