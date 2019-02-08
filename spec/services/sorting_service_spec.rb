require 'rails_helper'

RSpec.describe SortingService do
  let(:category) { create(:category) }
  let!(:book) { create(:book, name: 'B', category: category) }
  let!(:book2) { create(:book, name: 'A', category: category) }
  let(:params) { { sort_by: :asc_title, category_id: category.id } }

  describe 'sorting books' do
    let(:all_books) { Book.all }
    subject(:service) { described_class.new(all_books, params) }

    it 'sorting name books by ask' do
      # p all_books == all_books
      expect(service.call).to eq([book2, book])
      # p Book.all
    end
  end
end
