require 'rails_helper'

RSpec.describe ConfirmService do
  let(:user) { create(:user) }
  let(:order) { create(:order) }

  describe 'confirm success' do
    let(:params) { { user_id: user.id } }
    subject(:service) { described_class.new(params, user, order) }

    it do
      expect(service.call).to eq(true)
    end
  end

  describe 'confirm failed' do
    let(:params) { { user_id: user.id } }
    subject(:service) { described_class.new(params, user, nil) }

    it do
      expect(service.call).to eq(nil)
    end
  end
end
