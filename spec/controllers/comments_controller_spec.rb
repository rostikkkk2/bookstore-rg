require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:valid_attributes) { attributes_for(:comment) }
  let!(:user) { create(:user) }
  let(:book) { create(:book) }

  describe 'POST #create' do
    login_user

    it 'success' do
      post :create, params: { title: valid_attributes[:title], text_comment: valid_attributes[:description], current_user: user.id, current_book: book.id }
      expect(subject).to redirect_to book_path(book.id)
    end

    it 'failed' do
      post :create, params: { title: '', text_comment: '', current_user: user.id, current_book: book.id }
      expect(subject).to set_flash[:error]
    end
  end
end
