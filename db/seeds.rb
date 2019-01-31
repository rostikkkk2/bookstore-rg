require 'ffaker'

def generate_user
  user = User.new(first_name: FFaker::Name.name, email: FFaker::Internet.email, password: FFaker::Internet.password)
  user.save!
end

def generate_book
  user = Book.new(
    name: FFaker::Book.title,
    description: FFaker::Book.description(6),
    price: rand(30.20...99.99).round(2),
    category_id: rand(1..3),
    published_year: 2015,
    heigth: 6.4,
    width: 0.9,
    depth: 5.0,
    material: 'Hardcove, glossy paper'
  )
  # File.open("public/img/#{rand(1..14)}.jpg") do |f|
  #   user.photo = f
  # end
  user.save!
end

def generate_authors
  Author.create(name: FFaker::Name.name)
end

def generate_authors_books
  books = Book.all
  authors = Author.all
  authors_id = authors.map { |author| author.id }
  books.each do |book|
    BookAuthor.create(book_id: book.id, author_id: authors_id[rand(authors_id.length)])
  end
end

def generate_categories
  Category.new(id: 1, name: 'Mobile development').save!
  Category.new(id: 2, name: 'Photo').save!
  Category.new(id: 3, name: 'Web disign').save!
end

generate_categories
15.times { generate_book }
15.times { generate_authors }
generate_authors_books
