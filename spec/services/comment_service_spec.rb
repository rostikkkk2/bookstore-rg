require 'rails_helper'

RSpec.describe CommentService do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:comment_attr) { attributes_for(:comment) }
  let(:comments_form_params) { { title: comment_attr[:title], text_comment: comment_attr[:title], rating: 4, current_user: user.id, current_book: book.id } }

  describe 'create comment' do
    context 'when success' do
      subject(:service) { described_class.new(comments_form_params) }

      let(:count_comment_after_create) { 1 }

      it do
        service.save_comment
        expect(Comment.count).to eq(count_comment_after_create)
      end
    end

    context 'when failed' do
      subject(:service) { described_class.new({}) }

      it do
        expect(service.save_comment).to eq(nil)
        expect(Comment.all).to eq([])
      end
    end
  end
end
