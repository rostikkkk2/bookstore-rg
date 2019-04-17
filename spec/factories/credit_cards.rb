FactoryBot.define do
  factory :credit_card do
    number { Array.new(16) { [rand(0..9)] }.join }
    name { 'universal' }
    date { '12/21' }
    cvv { Array.new(3) { [rand(1..9)] }.join }

  end
end
