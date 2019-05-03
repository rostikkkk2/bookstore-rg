require 'rails_helper'

RSpec.describe CheckoutUpdateService do
  let(:user) { create(:user) }
  let(:valid_inputs) { attributes_for(:address) }
  let(:order) { create(:order, status: :address) }
  let(:valid_params_for_address) { {
    step: "address",
    billing_form: {
      address_type: :billing,
      user_id: user.id,
      first_name: valid_inputs[:first_name],
      last_name: valid_inputs[:last_name],
      address: valid_inputs[:address],
      city: valid_inputs[:city],
      zip: valid_inputs[:zip],
      country: valid_inputs[:country],
      phone: valid_inputs[:phone]
    },
    hidden_shipping_form: true
  } }

  describe 'address checkout service success' do
    subject(:service) { described_class.new(valid_params_for_address, order, user) }

    it do
      expect(service.call).to eq(true)
    end
  end

  describe 'address checkout service failed' do
    let(:invalid_params_for_address) { { step: "address", billing_form: {}, hidden_shipping_form: true } }
    subject(:service) { described_class.new(invalid_params_for_address, order, user) }

    it do
      expect(service.call).to eq(false)
    end
  end
end
