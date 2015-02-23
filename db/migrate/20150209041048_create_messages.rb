class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
	  t.string "body", null: false
	  t.belongs_to :user, index: true, null: false
	  t.string "channel_id", index: true, null: false
	  t.string "channel_type", index: true, null: false
	  
      t.timestamps null: false
    end
	  add_foreign_key :messages, :users
  end
end
