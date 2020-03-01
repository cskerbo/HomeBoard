class CreateBulbs < ActiveRecord::Migration[5.1]
  def change
    create_table :bulbs do |t|
      t.integer :bridge_id
      t.string :name
      t.boolean :on
      t.integer :brightness
      t.integer :hue
      t.integer :saturation
      t.integer :color_temperature
      t.string :color_mode
      t.string :effect
      t.integer :identifier
    end
  end
end
