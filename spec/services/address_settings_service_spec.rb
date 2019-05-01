require 'rails_helper'

RSpec.describe AddressSettingsService do
  let(:user) { create(:user) }
  let(:valid_zip) { 123 }
  let(:valid_input) { 'teesttest' }
  let(:valid_name) { 'Test' }
  let(:valid_phone) { '+594962858055' }
  let(:valid_city) { 'French Guiana' }
  let(:order) { create(:order, user_id: user.id) }
  let(:valid_address_params_billing) { { billing_form: { address_type: "billing", user_id: user.id, first_name: valid_name, last_name: valid_name, address: valid_city, city: valid_city, zip: valid_zip, country: valid_city, phone: valid_phone } } }


  # before do
  #   valid_address_params_billing.permit(:address_type, :user_id, :first_name, :last_name, :address, :city, :zip, :country, :phone)
  # end

  describe 'create settings address' do
    subject(:service) { described_class.new(valid_address_params_billing, user, order) }

    # it 'valid new address' do
    #   expect(service.call).to eq(true)
    # end
  end
end