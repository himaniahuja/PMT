class AlterComplaxityAndUnit < ActiveRecord::Migration
  def self.up
    rename_table :complexity_templates, :complexities
    rename_table :unit_of_measure_templates, :units
  end

  def self.down
    rename_table :complexities,:complexity_templates
    rename_table :units,:unit_of_measure_templates
  end
end
