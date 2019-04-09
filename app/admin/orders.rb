ActiveAdmin.register Order do
  permit_params :status, :user_id, :delivery_id, :created_at

  includes :coupon
  actions :index, :show

  scope :in_progress, default: true
  scope :in_delivery
  scope :delivered
  scope :canceled

  config.filters = false

  index do
    selectable_column

    column :number
    column :status
    column :created_at

    actions
  end

  show do
    attributes_table do
      row :number
      row :status
      row :created_at
      row :coupon
      row :delivery_id

    end
  end


end
