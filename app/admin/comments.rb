ActiveAdmin.register Comment, as: 'BookComment' do
  permit_params :title, :text_comment, :rating, :status, :is_verified, :user_id, :book_id

  actions :index, :show

  scope :unprocessed, default: true
  scope :approved
  scope :rejected

  config.filters = false

  index do
    selectable_column
    column :title
    column :text_comment
    column :rating
    column :is_verified
    column :status
    column :user
    column :book

    actions
  end

  batch_action I18n.t('admin.approve'), if: proc { @current_scope.scope_method == :unprocessed } do |ids|
    comments = Comment.unprocessed.where(id: ids)
    comments.any? ? comments.each(&:approved!) : flash[:error] = I18n.t('admin.error')
    redirect_to(admin_book_comments_path)
  end

  batch_action I18n.t('admin.reject'), if: proc { @current_scope.scope_method == :unprocessed } do |ids|
    comments = Comment.unprocessed.where(id: ids)
    comments.any? ? comments.each(&:rejected!) : flash[:error] = I18n.t('admin.error')
    redirect_to(admin_book_comments_path)
  end

  batch_action I18n.t('admin.destroy') do |ids|
    comments = Comment.where(id: ids)
    comments.any? ? comments.destroy_all : flash[:error] = I18n.t('admin.error')
    redirect_to(admin_book_comments_path)
  end
end
