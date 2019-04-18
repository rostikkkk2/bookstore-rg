require 'rails_helper'

RSpec.describe BookAuthor, type: :model do
  context 'with database columns' do
    it { is_expected.to have_db_index(:book_id) }
    it { is_expected.to have_db_index(:author_id) }
  end

  context 'with assosiations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:author) }
  end
end
