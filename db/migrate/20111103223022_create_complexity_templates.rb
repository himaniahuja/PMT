class CreateComplexityTemplates < ActiveRecord::Migration
  def self.up
    create_table :complexity_templates do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :complexity_templates
  end
end
