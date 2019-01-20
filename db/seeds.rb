require 'ffaker'

def generate_user
  user = User.new(first_name: FFaker::Name.name, email: FFaker::Internet.email, password: FFaker::Internet.password)
  user.save!
end

def generate_book
  user = Book.new(
    name: FFaker::Book.title,
    description: 'cool book',
    author: FFaker::Name.name,
    photo: "javascript-and-jquery-book-cover.png",
    price: rand(30.20...99.99).round(2),
    category_id: rand(1..3)
  )
  user.save!
end

def generate_categories
  Category.new(id: 1, name: 'Mobile development').save!
  Category.new(id: 2, name: 'Photo').save!
  Category.new(id: 3, name: 'Web disign').save!
end

# 4.times { generate_user }
# generate_categories
10.times { generate_book }
