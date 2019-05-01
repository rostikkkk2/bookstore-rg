require 'rails_helper'

RSpec.describe CartCreateService do
  let(:current_user) { create(:user) }
  let(:current_order) { create(:order, user_id: current_user.id) }
  let(:book) { create(:book) }
  # let(:params_request) { {current_user: current_user.id, current_book: book.id, count_books: 1 } permitted: true }
  let(:params) { { current_user: current_user.id, current_book: book.id, count_books: 1 } }

  describe 'cart create' do
    # subject(:service) { described_class.new(current_user, params_request, params) }

    it do

    end

  end

end
