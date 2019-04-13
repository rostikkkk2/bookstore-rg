FactoryBot.define do
  factory :address do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::Address.street_name }
    city { FFaker::Address.city }
    zip { '1234' }
    country { FFaker::Address.country }
    phone { '+380333333333' }
    address_type { nil }
    resource { nil }
  end
end
