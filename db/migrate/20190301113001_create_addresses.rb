class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.integer :zip
      t.string :country
      t.string :phone
      t.integer :address_type
      t.integer :resource_id, index: true
      t.string :resource_type, index: true
      t.timestamps
    end
  end
end
