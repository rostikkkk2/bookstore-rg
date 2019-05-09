require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  let(:user) { create(:user) }
  let(:order) { create(:order, user: user) }

  before do
    sign_in user
    allow(subject).to receive(:current_user).and_return(user)
    allow(subject).to receive(:current_order).and_return(order)
  end

  describe 'GET #show' do
    before do
      get :show, params: { step: :address }
    end

    it do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT #update' do
    before do
      put :update, params: { step: :payment, credit_card_form:
                             { order_id: 1,
                               number: '3333333333333333',
                               name: 'universal',
                               date: '12/21',
                               cvv: 333 } }
    end

    it 'success' do
      expect(response).to have_http_status(:success)
    end
  end
end
