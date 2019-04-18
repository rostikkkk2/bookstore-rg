require 'rails_helper'

describe 'Comments in book page', type: :feature do
  let!(:user) { create(:user) }
  let(:new_category) { create(:category, name: 'Mobile') }
  let!(:book) { create(:book, category: new_category) }
  let(:error_message) { "Title can't be blank and Text comment can't be blank" }
  let(:error_empty_body_message) { "Text comment can't be blank" }
  let(:error_empty_title_message) { "Title can't be blank" }

  before do
    login_as(user, scope: :user)
    visit book_path(book)
  end

  it 'send comment with invalid fields' do
    click_on(I18n.t('book_page.comment.post'))
    expect(page).to have_content error_message
  end

  it 'send comment with invalid body comment' do
    fill_in 'title', with: '123'
    click_on(I18n.t('book_page.comment.post'))
    expect(page).to have_content error_empty_body_message
  end

  it 'send comment with invalid title comment' do
    fill_in 'text_comment', with: '123'
    click_on(I18n.t('book_page.comment.post'))
    expect(page).to have_content error_empty_title_message
  end

  it 'send comment with valid comment' do
    fill_in 'text_comment', with: 'test_title'
    fill_in 'title', with: 'test_body'
    click_on(I18n.t('book_page.comment.post'))
    expect(page).to have_content user.email
  end
end
