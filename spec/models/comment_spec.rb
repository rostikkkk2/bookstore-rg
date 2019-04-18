require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'with database columns' do
    it { is_expected.to have_db_column(:title).of_type(:string) }
    it { is_expected.to have_db_column(:text_comment).of_type(:text) }
    it { is_expected.to have_db_column(:rating).of_type(:integer).with_options(default: 0) }
    it { is_expected.to have_db_column(:is_verified).of_type(:boolean).with_options(default: false) }
    it { is_expected.to have_db_index(:user_id) }
    it { is_expected.to have_db_index(:book_id) }
  end

  context 'with assosiations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
  end
end
