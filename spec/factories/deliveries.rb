FactoryBot.define do
  factory :delivery do
    from_days { rand(2..4) }
    to_days { rand(5..9) }
    price { rand(10..30) }
  end
end
