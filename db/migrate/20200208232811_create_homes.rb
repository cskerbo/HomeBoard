class CreateHomes < ActiveRecord::Migration[5.1]
  def change
    create_table :homes do |t|
      t.string :name
      t.integer :zip_code
      t.string :street
      t.string :city
      t.string :state
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :timezone
      t.boolean :weather_widget, default: false
      t.integer :weather_widget_id
      t.boolean :pet_widget, default: false
      t.boolean :list_widget, default: false
      t.boolean :hue_widget, default: false

      t.timestamps
    end
  end
end
