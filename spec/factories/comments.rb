FactoryBot.define do
  factory :comment do
    title { FFaker::Name.name }
    description { FFaker::Lorem.word }
  end
end
