require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user) }
  let(:order) { create(:order, :complete_step) }

  describe 'GET #index' do
    login_user
    it do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    login_user
    it do
      get :show, params: { id: order.id }
      expect(response).to have_http_status(:success)
    end
  end
end
