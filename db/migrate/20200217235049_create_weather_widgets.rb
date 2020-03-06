class CreateWeatherWidgets < ActiveRecord::Migration[5.1]
  def change
    create_table :weather_widgets do |t|
      t.integer :home_id

      t.timestamps
    end
  end
end
