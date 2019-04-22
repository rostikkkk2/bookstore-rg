require 'rails_helper'

RSpec.describe LineItemsController, type: :controller do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  # describe 'POST #create' do
  #   it do
  #     post :create, params: { current_user: user, current_book: book, count_books: '1' }
  #     is_expected.to redirect_message(LineItemsController::SUCCESS_ADDED_IN_CART, :success)
  #     # is_expected.to redirect_to(request.referrer)
  #     pry
  #   end
  # end
end
