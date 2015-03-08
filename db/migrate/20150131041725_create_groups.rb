class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :slug, index: true, null: false, default: ""
      t.string :name, null: false
      t.text :description

      t.timestamps null: false
    end
  end
end
