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
      t.integer :weather_id
      t.string :weather_main
      t.string :weather_description
      t.string :weather_icon
      t.float :current_temp
      t.float :feels_like
      t.float :temp_min
      t.float :temp_max
      t.integer :sunrise
      t.integer :sunset
      t.string :timezone

      t.timestamps
    end
  end
end
