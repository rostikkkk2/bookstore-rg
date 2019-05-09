require 'rails_helper'

RSpec.describe AddressCheckoutService do
  let(:user) { create(:user) }
  let(:valid_zip) { 123 }
  let(:valid_input) { 'teesttest' }
  let(:valid_name) { 'Test' }
  let(:valid_phone) { '+594962858055' }
  let(:valid_city) { 'French Guiana' }
  let(:order) { create(:order, user_id: user.id) }
  let(:valid_billing_and_shipping) { {
    billing_form: { address_type: :billing, order_id: order.id, first_name: valid_name, last_name: valid_name, address: valid_city, city: valid_city, zip: valid_zip, country: valid_city, phone: valid_phone },
    shipping_form: { address_type: :shipping, order_id: order.id, first_name: valid_name, last_name: valid_name, address: valid_city, city: valid_city, zip: valid_zip, country: valid_city, phone: valid_phone }
  } }

  describe 'create checkout addresses success' do
    let(:count_after_create) { 2 }
    subject(:service) { described_class.new(valid_billing_and_shipping, user, order) }

    it 'valid new address' do
      expect(service.call).to eq(true)
      expect(order.addresses.count).to eq(count_after_create)
    end
  end

  describe 'create checkout addresses failed' do
    let(:invalid_billing_and_shipping) { { billing_form: {}, shipping_form: {} } }
    subject(:service) { described_class.new(invalid_billing_and_shipping, user, order) }

    it 'invalid new address' do
      expect(order.addresses).to eq([])
      expect(service.call).to eq(nil)
    end
  end

  describe 'create checkout addresses with hidden shipping form success' do
    let(:valid_billing_and_hidden_shipping) { {
      billing_form: { address_type: :billing, order_id: order.id, first_name: valid_name, last_name: valid_name, address: valid_city, city: valid_city, zip: valid_zip, country: valid_city, phone: valid_phone },
      hidden_shipping_form: true
    } }
    subject(:service) { described_class.new(valid_billing_and_hidden_shipping, user, order) }
    let(:count_after_create) { 2 }

    it 'valid new address' do
      expect(service.call).to eq(true)
      expect(order.addresses.billing.first.first_name).to eq(order.addresses.shipping.first.first_name)
      expect(order.addresses.billing.first.phone).to eq(order.addresses.shipping.first.phone)
      expect(Address.count).to eq(count_after_create)
    end
  end

  describe 'create checkout addresses with hidden shipping form failed' do
    let(:invalid_billing_and_hidden_shipping) { { billing_form: {}, hidden_shipping_form: true } }
    subject(:service) { described_class.new(invalid_billing_and_hidden_shipping, user, order) }

    it 'valid new address' do
      expect(order.addresses).to eq([])
      expect(service.call).to eq(nil)
    end
  end
end
