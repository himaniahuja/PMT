class AddTypeIdToDeliverableTemplates < ActiveRecord::Migration
  def self.up
    add_column :deliverable_templates, :type_id, :integer
  end

  def self.down
    remove_column :deliverable_templates, :type_id
  end
end
