FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end
    password { BCrypt::Password.create('123456') }
  end
end
