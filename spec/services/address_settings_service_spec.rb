require 'rails_helper'

RSpec.describe AddressSettingsService do
  let(:user) { create(:user) }
  let(:valid_zip) { 123 }
  let(:valid_input) { 'teesttest' }
  let(:valid_name) { 'Test' }
  let(:valid_phone) { '+594962858055' }
  let(:valid_city) { 'French Guiana' }
  let(:order) { create(:order, user_id: user.id) }

  describe 'create settings address success' do
    let(:count_address_after_create) { 1 }
    let(:valid_address_params_billing) { { billing_form: { address_type: :billing,
                                                           user_id: user.id,
                                                           first_name: valid_name,
                                                           last_name: valid_name,
                                                           address: valid_city,
                                                           city: valid_city,
                                                           zip: valid_zip,
                                                           country: valid_city,
                                                           phone: valid_phone } } }
    subject(:service) { described_class.new(valid_address_params_billing, user, order) }

    it 'valid new address' do
      expect(service.call).to eq(true)
      expect(user.addresses.billing.count).to eq(count_address_after_create)
    end
  end

  describe 'create settings address failed' do
    let(:invalid_address_params_billing) { { billing_form: {} } }
    subject(:service) { described_class.new(invalid_address_params_billing, user, order) }

    it 'invalid new address' do
      expect(service.call).to eq(false)
      expect(user.addresses).to eq([])
    end
  end
end
