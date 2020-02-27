class CreateHueWidgets < ActiveRecord::Migration[5.1]
  def change
    create_table :hue_widgets do |t|
      t.integer :home_id
      t.string :username
    end
  end
end
