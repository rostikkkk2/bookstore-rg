require 'rails_helper'

RSpec.describe Delivery, type: :model do
  context 'with database columns' do
    it { is_expected.to have_db_column(:method).of_type(:string) }
    it { is_expected.to have_db_column(:from_days).of_type(:integer) }
    it { is_expected.to have_db_column(:to_days).of_type(:integer) }
    it { is_expected.to have_db_column(:price).of_type(:decimal) }
  end

  context 'with assosiations' do
    it { is_expected.to have_many(:orders) }
  end
end
