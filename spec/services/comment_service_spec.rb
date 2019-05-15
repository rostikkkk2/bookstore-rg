require 'rails_helper'

RSpec.describe CommentService do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:comment_attr) { attributes_for(:comment) }
  let(:comments_form_params) { { title: comment_attr[:title], text_comment: comment_attr[:title], rating: 4, current_user: user.id, current_book: book.id } }
  let(:count_comment_after_create) { 1 }

  describe 'create comment' do
    context 'when success' do
      subject(:service) { described_class.new(comments_form_params) }

      it 'when create' do
        expect { service.save_comment }.to change(Comment, :count).from(0).to(count_comment_after_create)
        expect(Comment.first.title).to eq(comments_form_params[:title])
        expect(Comment.first.text_comment).to eq(comments_form_params[:text_comment])
        expect(Comment.first.rating).to eq(comments_form_params[:rating])
      end
    end

    context 'when failed' do
      subject(:service) { described_class.new({}) }

      it 'when not create' do
        expect(service.save_comment).to eq(nil)
        expect(Comment.all).to be_empty
      end
    end
  end
end
