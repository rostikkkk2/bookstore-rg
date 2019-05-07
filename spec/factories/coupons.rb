FactoryBot.define do
  factory :coupon do
    key { FFaker::Name.name }
    discount { rand(20...40) }
  end
end
