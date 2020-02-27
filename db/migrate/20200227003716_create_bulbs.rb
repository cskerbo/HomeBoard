class CreateBulbs < ActiveRecord::Migration[5.1]
  def change
    create_table :bulbs do |t|
      t.integer :bridge_id
    end
  end
end
