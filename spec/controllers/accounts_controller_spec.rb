require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  describe 'DELETE #destroy' do
    login_user
    let(:user) { User.first }

    it 'success' do
      delete :destroy, params: { id: user.id }
      allow(subject).to receive(:current_user).and_return(user)
      allow(User).to receive(:find_by).and_return(user)
      is_expected.to set_flash[:success]
      is_expected.to redirect_to root_path
    end

    # context 'failed delete account' do
    #
    #   before do
    #     allow(subject).to receive(:current_user).and_return([])
    #   end
    #
    #   it 'failed' do
    #     delete :destroy, params: { id: '' }
    #     # allow(:current_user.destroy).to eq(false)
    #     is_expected.to set_flash[:error]
    #     is_expected.to redirect_to root_path
    #   end
    # end
  end

  describe 'PUT #update' do
    let(:user) { create(:user) }
    let(:valid_attributes) { attributes_for(:user)}

    before do
      sign_in user
      allow(subject).to receive(:current_user).and_return(user)
    end

    it 'success' do
      put :update, params: { id: user.id, old_password: user.password, new_password: user.password, confirm_password: user.password }
      is_expected.to set_flash[:success]
      is_expected.to redirect_to new_setting_path
    end

    it 'failed' do
      put :update, params: { id: user.id, old_password: user.password, new_password: valid_attributes[:password], confirm_password: user.password }
      is_expected.to set_flash[:error]
      is_expected.to redirect_to new_setting_path
    end
  end
end
