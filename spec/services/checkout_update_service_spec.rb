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
    let!(:address) { order.addresses.create!(attributes_for(:address, :billing)) }

    it 'when address update' do
      expect { service.call }.to change { address.reload.first_name }.from(address.first_name)
        .to(valid_params_for_address[:billing_form][:first_name]).and change { address.reload.last_name }
        .from(address.reload.last_name).to(valid_params_for_address[:billing_form][:last_name])
        .and change { address.reload.address }.from(address.reload.address).to(valid_params_for_address[:billing_form][:address])
        .and change { address.reload.city }.from(address.reload.city).to(valid_params_for_address[:billing_form][:city])
    end
  end

  describe 'address checkout service failed' do
    subject(:service) { described_class.new(invalid_params_for_address, order, user) }

    let(:invalid_params_for_address) { { step: 'address', billing_form: {}, hidden_shipping_form: true } }

    it 'when address failed' do
      expect(service.call).to eq(false)
    end
  end
end
