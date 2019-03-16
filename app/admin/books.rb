ActiveAdmin.register Book do
  permit_params :name, :description, :photo, :published_year, :heigth, :width, :depth, :material, :price, :category_id, author_ids: []

  index do
    selectable_column

    column :photo do |book|
      image_tag book.photo.url.to_s, class: 'admin-image-book'
    end

    column :name do |book|
      link_to book.name, resource_path(book)
    end

    column :authors do |book|
      book.authors.map(&:name).join(', ')
    end

    column :category

    column :price do |book|
      "€#{book.price}"
    end
    actions
  end

  show do
    attributes_table do
      row :name

      row :photo do |book|
        image_tag book.photo.url.to_s, class: 'admin-image-book'
      end

      row :author do |book|
        book.authors.map(&:name).join(', ')
      end

      row :description
      row :published_year
      row :category
      row :heigth
      row :width
      row :depth
      row :material

      row :price do |book|
        "€#{book.price}"
      end
    end
  end

  form(html: { multipart: true }) do |f|
    f.inputs 'Add/Edit Article' do
      f.input :category, as: :radio
      f.input :name
      f.input :authors, as: :check_boxes
      f.input :description
      f.input :price
      f.input :published_year
      f.input :heigth
      f.input :width
      f.input :depth
      f.input :material

      f.inputs "Upload book cover" do
        f.input :photo, required: true, as: :file
      end
    end
    actions
  end
end
