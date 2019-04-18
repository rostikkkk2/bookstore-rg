require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'with database columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:description).of_type(:text) }
    it { is_expected.to have_db_column(:photo).of_type(:string) }
    it { is_expected.to have_db_column(:published_year).of_type(:integer) }
    it { is_expected.to have_db_column(:heigth).of_type(:float) }
    it { is_expected.to have_db_column(:width).of_type(:float) }
    it { is_expected.to have_db_column(:depth).of_type(:float) }
    it { is_expected.to have_db_column(:material).of_type(:string) }
    it { is_expected.to have_db_column(:price).of_type(:decimal) }
    it { is_expected.to have_db_index(:category_id) }
  end

  context 'with assosiations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:book_authors).dependent(:destroy) }
    it { is_expected.to have_many(:authors).through(:book_authors) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:line_items).dependent(:destroy) }
  end
end
