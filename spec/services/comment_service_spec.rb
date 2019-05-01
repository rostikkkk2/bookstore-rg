require 'rails_helper'

RSpec.describe CommentService do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:comment_attr) { attributes_for(:comment) }
  let(:comments_form_params) { { title: comment_attr[:title], text_comment: comment_attr[:title], rating: 4, current_user: user.id, current_book: book.id } }

  describe 'create comment' do
    context 'when success' do
      subject(:service) { described_class.new(comments_form_params) }

      it do
        expect(service.save_comment).to eq(true)
      end
    end

    context 'when failed' do
      subject(:service) { described_class.new({}) }

      it do
        expect(service.save_comment).to eq(nil)
      end
    end
  end
end
