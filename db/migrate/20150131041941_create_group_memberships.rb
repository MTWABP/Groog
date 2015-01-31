class CreateGroupMemberships < ActiveRecord::Migration
  def change
    create_table :group_memberships do |t|
      t.belongs_to :user, index: true, null: false
      t.belongs_to :group, index: true, null: false
      t.boolean :active, default: false

      t.timestamps null: false
    end
    add_foreign_key :group_memberships, :groups
    add_foreign_key :group_memberships, :users
  end
end
