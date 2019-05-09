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

  batch_action I18n.t('admin.change_on_in_delivery'), if: proc { @current_scope.scope_method == :in_progress } do |ids|
    orders = Order.in_progress.where(id: ids)
    orders.any? ? orders.each(&:in_delivery!) : flash[:error] = I18n.t('admin.error')
    redirect_to(admin_orders_path)
  end

  batch_action I18n.t('admin.change_on_delivered'), if: proc { @current_scope.scope_method == :in_delivery } do |ids|
    orders = Order.in_delivery.where(id: ids)
    orders.any? ? orders.each(&:delivered!) : flash[:error] = I18n.t('admin.error')
    redirect_to(admin_orders_path)
  end

  batch_action I18n.t('admin.change_on_canceled'), if: proc { @current_scope.scope_method != :canceled } do |ids|
    orders = Order.where(id: ids)
    orders.any? ? orders.each(&:canceled!) : flash[:error] = I18n.t('admin.error')
    redirect_to(admin_orders_path)
  end
end
