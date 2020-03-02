class CreateScenes < ActiveRecord::Migration[5.1]
  def change
    create_table :scenes do |t|
      t.string :identifier
      t.string :name
      t.integer :group_id
      t.integer :group_number
    end
  end
end
