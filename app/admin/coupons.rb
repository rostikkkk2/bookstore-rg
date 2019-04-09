ActiveAdmin.register Coupon do
  permit_params :key, :discount, :order_id, :used

  scope :unused, default: true
  scope :was_used

  config.filters = false

  index do
    selectable_column

    column :key
    column :discount
    column :order_id
    column :used

    actions
  end

  form(html: { multipart: true }) do |f|
    f.inputs 'Add/Edit Article' do
      f.input :key
      f.input :discount
    end
    actions
  end
end
