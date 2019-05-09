require 'rails_helper'

RSpec.describe EmailService do
  let(:user) { create(:user) }

  describe 'update email success' do
    let(:params) { { email: 'test@gmail.com', user_id: user.id } }
    subject(:service) { described_class.new(params, user) }

    it do
      expect(service.save).to eq(true)
      expect(user.email).to eq(params[:email])
    end
  end

  describe 'update email failed' do
    let(:params) { { email: '', user_id: user.id } }
    subject(:service) { described_class.new(params, user) }

    it do
      expect(service.save).to eq(nil)
      expect(user.email).not_to eq(params[:email])
    end
  end
end
