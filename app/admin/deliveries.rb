ActiveAdmin.register Delivery, as: 'delivery_type' do
  permit_params :method, :from_days, :to_days, :price
  config.filters = false

  index do
    selectable_column

    column :method
    column :from_days
    column :to_days
    column :price
  end
end
