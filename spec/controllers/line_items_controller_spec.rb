require 'rails_helper'

RSpec.describe LineItemsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:book) { create(:book) }
  let(:order) { create(:order) }

  before { allow(controller).to receive(:current_order).and_return(order) }

  describe 'POST #create' do
    it do
      expect(subject).to receive(:redirect_back).and_call_original
      post :create, params: { current_user: user, current_book: book, count_books: '1' }
      is_expected.to redirect_to root_path
    end
  end

  describe 'DELETE #destroy' do
    # before { allow(LineItem).to receive(:find_by).and_return(order.line_items.last) }

    # before do
    #   allow_any_instance_of(LineItem).to receive(:destroy).and_return(true)
    #   # pry
    #   delete :destroy, params: { id: order.line_items.last.book.id }
    # end
    #
    # it do
    #   is_expected.to set_flash[:success]
    # end
  end

  describe 'PUT #update' do
    let(:line_item) { order.line_items.last }

    before do
      allow(LineItem).to receive(:find_by).and_return(line_item)
      put :update, params: { id: line_item.book.id, plus: true }
    end

    it do
      is_expected.to redirect_to carts_path
    end
  end
end
