require 'rails_helper'

RSpec.describe ChangePasswordService do
  let(:current_user) { create(:user, password: 'test123') }
  let(:test_value_password) { '123456' }
  let(:params_success) { { old_password: current_user.password, new_password: test_value_password, confirm_password: test_value_password } }
  let(:params_failed) { { old_password: current_user.password, new_password: FFaker::Lorem.word, confirm_password: FFaker::Lorem.word } }

  describe 'change password success' do
    subject(:service) { described_class.new(current_user, params_success) }

    it 'when password change' do
      expect { service.call }.to change { current_user.password }.from(current_user.password).to(test_value_password)
    end
  end

  describe 'change password failed' do
    subject(:service) { described_class.new(current_user, params_failed) }

    it 'when password not change' do
      expect(service.call).to eq(nil)
    end
  end
end
