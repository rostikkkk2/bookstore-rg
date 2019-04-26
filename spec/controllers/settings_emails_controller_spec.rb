require 'rails_helper'

RSpec.describe SettingsEmailsController, type: :controller do
  let(:user) { create(:user) }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe 'PUT #update' do
    login_user

    it 'success' do
      put :update, params: { user_id: user.id, email: user.email, id: user.id }
      is_expected.to set_flash[:success]
      is_expected.to redirect_to(new_setting_path)
    end

    it 'failed' do
      put :update, params: { user_id: user.id, email: '', id: user.id }
      is_expected.to set_flash[:error]
      is_expected.to redirect_to(new_setting_path)
    end
  end
end
