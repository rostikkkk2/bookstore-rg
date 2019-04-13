require 'rails_helper'

RSpec.describe SortingService do
  let(:category) { create(:category) }
  let!(:book) { create(:book, name: 'A', category: category, price: 10) }
  let!(:book2) { create(:book, name: 'B', category: category, price: 5) }
  let(:all_books) { Book.all }

  let(:params_asc_title) { { sort_by: :asc_title, category_id: category.id } }
  let(:params_desc_title) { { sort_by: :desc_title, category_id: category.id } }
  let(:params_asc_price) { { sort_by: :asc_price, category_id: category.id } }
  let(:params_desc_price) { { sort_by: :desc_price, category_id: category.id } }
  let(:params_newest_first) { { sort_by: :newest_first, category_id: category.id } }

  describe 'sorting books by ask' do
    subject(:service) { described_class.new(all_books, params_asc_title) }

    it do
      expect(service.call).to eq([book, book2])
    end
  end

  describe 'sorting books by desc' do
    subject(:service) { described_class.new(all_books, params_desc_title) }

    it do
      expect(service.call).to eq([book2, book])
    end
  end

  describe 'sorting books price by asc' do
    subject(:service) { described_class.new(all_books, params_asc_price) }

    it do
      expect(service.call).to eq([book2, book])
    end
  end

  describe 'sorting books price by desc' do
    subject(:service) { described_class.new(all_books, params_desc_price) }

    it do
      expect(service.call).to eq([book, book2])
    end
  end

  describe 'sorting books by newest' do
    subject(:service) { described_class.new(all_books, params_newest_first) }

    it do
      expect(service.call).to eq([book2, book])
    end
  end
end
