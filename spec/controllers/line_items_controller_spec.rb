require 'rails_helper'

RSpec.describe LineItemsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:book) { create(:book) }
  let(:order) { create(:order) }

  before { allow(subject).to receive(:current_order).and_return(order) }

  describe 'POST #create' do
    it do
      expect(response).to have_http_status(:success)
      expect(subject).to receive(:redirect_back).and_call_original
      post :create, params: { current_user: user, current_book: book, count_books: '1' }
      is_expected.to redirect_to root_path
    end
  end

  describe 'DELETE #destroy' do
    it do
      expect(response).to have_http_status(:success)
      expect(subject).to receive(:redirect_back).and_call_original
      delete :destroy, params: { id: order.line_items.last.book.id }
      is_expected.to redirect_to root_path
    end
  end

  describe 'PUT #update' do
    let(:line_item) { order.line_items.last }

    it do
      expect(response).to have_http_status(:success)
      allow(LineItem).to receive(:find_by).and_return(line_item)
      put :update, params: { id: line_item.book.id, plus: true }
      is_expected.to redirect_to carts_path
    end
  end
end
