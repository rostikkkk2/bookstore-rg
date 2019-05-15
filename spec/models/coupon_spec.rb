require 'rails_helper'

RSpec.describe Coupon, type: :model do
  context 'with database columns' do
    it { is_expected.to have_db_column(:key).of_type(:string) }
    it { is_expected.to have_db_column(:discount).of_type(:decimal).with_options(default: 20.0) }
  end

  context 'with assosiations' do
    it { is_expected.to have_many(:orders) }
  end
end
