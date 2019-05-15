FactoryBot.define do
  factory :order do
    number { Array.new(ConfirmService::LENGTH_SECRET_NUMBER) { [rand(ConfirmService::RANGE_SECRET_NUMBER)] }.unshift(ConfirmService::BEGIN_SECRET_NUMBER).join }

    user

    after(:create) do |order|
      create(:line_item, order_id: order.id)
    end

    trait :address_step do
      status { Order.statuses[:address] }
    end

    trait :delivery_step do
      status { Order.statuses[:fill_delivery] }
    end

    trait :payment_step do
      after(:create) do |order|
        order.addresses.create!(attributes_for(:address, :billing))
        order.addresses.create!(attributes_for(:address, :shipping))
      end

      status { Order.statuses[:payment] }
    end

    trait :confirm_step do
      after(:create) do |order|
        order.addresses.create!(attributes_for(:address, :billing))
        order.addresses.create!(attributes_for(:address, :shipping))
        create(:credit_card, order_id: order.id)
      end

      status { Order.statuses[:confirm] }
    end

    trait :complete_step do
      after(:create) do |order|
        order.addresses.create!(attributes_for(:address, :billing))
        order.addresses.create!(attributes_for(:address, :shipping))
        create(:credit_card, order_id: order.id)
      end

      status { Order.statuses[:complete] }
    end

    trait :in_delivery_step do
      status { Order.statuses[:in_delivery] }
    end

    trait :delivered_step do
      status { Order.statuses[:delivered] }
    end

    trait :canceled_step do
      status { Order.statuses[:canceled] }
    end
  end
end
