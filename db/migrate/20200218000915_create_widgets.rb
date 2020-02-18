class CreateWidgets < ActiveRecord::Migration[5.1]
  def change
    create_table :widgets do |t|
      t.boolean :weather_widget, default: false
      t.integer :weather_widget_id
      t.boolean :pet_widget, default: false
      t.integer :pet_widget_id
      t.boolean :task_widget, default: false
      t.integer :task_widget_id
      t.boolean :grocery_widget, default: false
      t.integer :grocery_widget_id
      t.boolean :network_widget, default: false
      t.integer :network_widget_id
      t.boolean :ring_widget, default: false
      t.integer :ring_widget_id
      t.boolean :hue_widget, default: false
      t.integer :hue_widget_id
      t.home_id
      t.user_id
    end
  end
end
