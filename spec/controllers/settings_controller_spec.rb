require 'rails_helper'

RSpec.describe SettingsController, type: :controller do
  let(:user) { create(:user) }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe 'GET #new' do
    login_user

    it do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
end
