FactoryBot.define do
  factory :book do
    name { FFaker::Book.title }
    description { FFaker::Book.description(6) }
    price { rand(30.20...99.99).round(2) }
    photo { File.open('spec/fixtures/images/default.png') }
    published_year { 2015 }
    heigth { 6.4 }
    width { 0.9 }
    depth { 5.0 }
    material { 'Hardcove, glossy paper' }

    category
  end
end
