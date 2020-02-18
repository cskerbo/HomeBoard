class CreatePetsWidget < ActiveRecord::Migration[5.1]
  def change
    create_table :pets_widget do |t|
      t.datetime :feeding
      t.datetime :bathroom_break
      t.datetime :dog_walk
    end
  end
end
