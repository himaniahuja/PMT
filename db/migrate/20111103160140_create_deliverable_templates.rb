class CreateDeliverableTemplates < ActiveRecord::Migration
  def self.up
    create_table :deliverable_templates do |t|
      t.string :name
      t.text :description
      t.integer :phase_template_id

      t.timestamps
    end
  end

  def self.down
    drop_table :deliverable_templates
  end
end
