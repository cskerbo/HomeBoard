class CreateWeatherWidgets < ActiveRecord::Migration[5.1]
  def change
    create_table :weather_widgets do |t|
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
      t.integer :widget_id
      t.integer :home_id

      t.timestamps
    end
  end
end
