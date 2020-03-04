class CreatePets < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.string :status1, default: 'Feeding Status'
      t.string :status2, default: 'Outside Status'
      t.string :status1_message, default: 'The little fluff balls were fed at'
      t.string :status2_message, default: 'The dogs were let out at'
      t.string :status1_time
      t.string :status2_time
      t.string :day
      t.integer :home_id
    end
  end
end
