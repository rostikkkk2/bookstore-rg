class AddNumberToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :number, :string
  end
end
