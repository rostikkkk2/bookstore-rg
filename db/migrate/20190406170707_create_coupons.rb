class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :key
      t.decimal :discount, default: 20
      t.timestamps
    end
  end
end
