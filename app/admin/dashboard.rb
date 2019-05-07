ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate bashboard-store" do
        div I18n.t('admin.users_count', count: User.count)
        div I18n.t('admin.books_count', count: Book.count)
        div I18n.t('admin.orders_count', count: Order.count)
        div I18n.t('admin.authors_count', count: Author.count)
        div I18n.t('admin.comments_count', count: Comment.count)
        div I18n.t('admin.categories_count', count: Category.count)
      end
    end

  end
end
