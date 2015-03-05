class CreateUserColors < ActiveRecord::Migration
  def change
    create_table :user_colors do |t|

      t.timestamps null: false
    end
  end
end
