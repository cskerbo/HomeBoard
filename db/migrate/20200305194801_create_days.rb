class CreateDays < ActiveRecord::Migration[5.1]
  def change
    create_table :days do |t|
      t.string :date
      t.boolean :today, default: false
      t.string :summary
      t.string :icon
      t.string :sunset
      t.string :sunrise
      t.float :temp_high
      t.float :temp_low
      t.integer :weather_widget_id
      t.float :precipitation_chance
      t.string :precipitation_type
      t.float :feels_like
      t.float :current_temp
    end
  end
end
