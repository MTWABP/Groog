class AddToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :owner_id, :integer, null: false
    add_column :tasks, :assignee_id, :integer
    add_column :tasks, :group_id, :integer, null: false, index: true
    add_column :tasks, :completed, :boolean, null: false, default: false

    add_foreign_key :tasks, :groups
  end
end
