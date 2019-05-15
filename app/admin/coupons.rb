ActiveAdmin.register Coupon do
  permit_params :key, :discount

  config.filters = false

  index do
    selectable_column

    column :key
    column :discount

    actions
  end

  form(html: { multipart: true }) do |f|
    f.inputs I18n.t('admin.add_edit_article') do
      f.input :key
      f.input :discount
    end
    actions
  end
end
