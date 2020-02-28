class CreateBridges < ActiveRecord::Migration[5.1]
  def change
    create_table :bridges do |t|
      t.string :internalip
      t.string :identifier
      t.string :username
      t.integer :home_id
    end
  end
end
