class CreateWeatherWidget < ActiveRecord::Migration[5.1]
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
      t.integer :widgets_id
    end
  end
end
