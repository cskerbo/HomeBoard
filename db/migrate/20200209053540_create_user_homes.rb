class CreateUserHomes < ActiveRecord::Migration[5.1]
  def change
    create_table :user_homes do |t|
      t.integer :user_id
      t.integer :home_id

      t.timestamps
    end
  end
end
