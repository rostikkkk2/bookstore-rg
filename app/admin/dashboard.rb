ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate bashboard-store" do
        div "Users count: #{User.count}"
        div "Books count: #{Book.count}"
        div "Orders count: #{Order.count}"
        div "Authors count: #{Author.count}"
        div "Comments count: #{Comment.count}"
        div "Categories count: #{Category.count}"
      end
    end

  end
end
