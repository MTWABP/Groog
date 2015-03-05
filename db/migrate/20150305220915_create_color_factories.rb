class CreateColorFactories < ActiveRecord::Migration
  def change
    create_table :color_factories do |t|

      t.timestamps null: false
    end
  end
end
