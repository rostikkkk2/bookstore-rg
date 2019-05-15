require 'rails_helper'

RSpec.describe LineItem, type: :model do
  context 'with database columns' do
    it { is_expected.to have_db_column(:quantity).of_type(:integer) }
    it { is_expected.to have_db_index(:book_id) }
    it { is_expected.to have_db_index(:order_id) }
  end

  context 'with assosiations' do
    it { is_expected.to belong_to(:order).without_validating_presence }
    it { is_expected.to belong_to(:book) }
  end
end
