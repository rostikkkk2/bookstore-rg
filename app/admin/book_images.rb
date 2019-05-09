ActiveAdmin.register BookImage do
  permit_params :photo, :book_id

  index do
    selectable_column

    column :photo do |book|
      image_tag book.photo.url.to_s, class: 'admin-image-book'
    end

    column :book_id do |book|
      Book.find_by(id: BookImage.find_by(id: book.id.to_i).book_id)
    end

    actions
  end

  show do
    attributes_table do
      row :book_id do |book|
        Book.find_by(id: BookImage.find_by(id: book.id.to_i).book_id)
      end

      row :photo do |book|
        image_tag book.photo.url.to_s, class: 'admin-image-book'
      end
    end
  end
end
