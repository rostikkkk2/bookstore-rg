require 'rails_helper'

RSpec.describe ChangePasswordService do
  let(:current_user) { create(:user) }
  let(:test_value_password) { '123456' }
  let(:params_success) { { old_password: current_user.password, new_password: test_value_password, confirm_password: test_value_password } }
  let(:params_failed) { { old_password: current_user.password, new_password: FFaker::Lorem.word, confirm_password: FFaker::Lorem.word } }

  describe 'change password success' do
    subject(:service) { described_class.new(current_user, params_success) }

    it do
      expect(service.call).to eq(true)
      expect(current_user.password).to eq(test_value_password)
    end
  end

  describe 'change password failed' do
    subject(:service) { described_class.new(current_user, params_failed) }

    it do
      expect(service.call).to eq(nil)
    end
  end
end
