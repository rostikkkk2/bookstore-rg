require 'rails_helper'

RSpec.describe CheckoutUpdateService do
  let(:user) { create(:user) }
  let(:valid_inputs) { attributes_for(:address) }
  let(:order) { create(:order, status: :address) }
  let(:valid_params_for_address) do
    {
      step: 'address',
      billing_form: {
        address_type: :billing,
        order_id: order.id,
        first_name: valid_inputs[:first_name],
        last_name: valid_inputs[:last_name],
        address: valid_inputs[:address],
        city: valid_inputs[:city],
        zip: valid_inputs[:zip],
        country: valid_inputs[:country],
        phone: valid_inputs[:phone]
      },
      hidden_shipping_form: true
    }
  end

  describe 'address checkout service success' do
    subject(:service) { described_class.new(valid_params_for_address, order, user) }

    it do
      expect(service.call).to eq(true)
      expect(order.addresses.billing.first.first_name).to eq(valid_params_for_address[:billing_form][:first_name])
      expect(order.addresses.billing.first.last_name).to eq(valid_params_for_address[:billing_form][:last_name])
      expect(order.addresses.billing.first.phone).to eq(valid_params_for_address[:billing_form][:phone])
    end
  end

  describe 'address checkout service failed' do
    subject(:service) { described_class.new(invalid_params_for_address, order, user) }

    let(:invalid_params_for_address) { { step: 'address', billing_form: {}, hidden_shipping_form: true } }

    it do
      expect(service.call).to eq(false)
    end
  end
end
