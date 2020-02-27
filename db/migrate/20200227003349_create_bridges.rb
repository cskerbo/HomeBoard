class CreateBridges < ActiveRecord::Migration[5.1]
  def change
    create_table :bridges do |t|
      t.string :internalip
      t.string :identifier
      t.integer :hue_widget_id
    end
  end
end
