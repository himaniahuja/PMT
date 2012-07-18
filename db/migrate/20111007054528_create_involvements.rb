class CreateInvolvements < ActiveRecord::Migration
  def self.up
    create_table :involvements do |t|
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end


    add_index :involvements, :user_id
    add_index :involvements, :project_id

  end

  def self.down
    drop_table :involvements
  end
end
