class CreateInvites < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :invites, id: :uuid do |t|
      t.belongs_to :group, null: false, default: 1

      t.timestamps null: false
    end
  end
end
