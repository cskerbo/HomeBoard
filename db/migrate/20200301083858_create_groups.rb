class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.text :lights, array: true, default: []
      t.string :name
      t.string :group_type
      t.integer :identifier
      t.boolean :state
      t.integer :brightness
      t.integer :bridge_id
    end
  end
end
