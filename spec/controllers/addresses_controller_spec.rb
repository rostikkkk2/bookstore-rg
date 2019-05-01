require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  let(:user) { create(:user) }
  let(:order) { create(:order, user_id: user.id) }

  before do
    sign_in user
    allow(subject).to receive(:current_user).and_return(user)
    allow(subject).to receive(:current_order).and_return(order)
  end

  describe 'POST #create' do
    it 'success' do
      post :create, params: { billing_form: attributes_for(:address) }
      expect(response).to have_http_status(:success)
    end

    it 'failed' do
      post :create, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end
end
