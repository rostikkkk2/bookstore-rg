FactoryBot.define do
  factory :line_item do
    quantity { rand(1..5) }

    book
  end
end
