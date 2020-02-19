class CreatePets < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.string :feeding, default: 'None yet! Update to show a time.'
      t.string :bathroom_break, default: 'None yet! Update to show a time.'
      t.string :walk
      t.string :pet_type
      t.integer :home_id
    end
  end
end
