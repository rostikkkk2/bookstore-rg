ActiveAdmin.register Comment, as: "BookComment" do
  permit_params :title, :text_comment, :rating, :is_verified, :user_id, :book_id

  index do
    selectable_column
    column :title
    column :text_comment
    column :rating
    column :is_verified
    column :user
    column :book

    actions
  end
end
