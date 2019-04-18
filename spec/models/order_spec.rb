require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'with database columns' do
    it { is_expected.to have_db_column(:status).of_type(:integer) }
    it { is_expected.to have_db_column(:number).of_type(:string) }
    it { is_expected.to have_db_index(:user_id) }
    it { is_expected.to have_db_index(:delivery_id) }
  end

  context 'with assosiations' do
    it { is_expected.to have_many(:line_items) }
    it { is_expected.to have_many(:addresses) }
    it { is_expected.to belong_to(:delivery).without_validating_presence }
    it { is_expected.to belong_to(:user).without_validating_presence }
    it { is_expected.to have_one(:coupon) }
    it { is_expected.to have_one(:credit_card) }
  end

  context 'with enum statuses' do
    it { expect(Order.statuses[:cart]).to eq 0 }
    it { expect(Order.statuses[:address]).to eq 1 }
    it { expect(Order.statuses[:delivery]).to eq 2 }
    it { expect(Order.statuses[:payment]).to eq 3 }
    it { expect(Order.statuses[:confirm]).to eq 4 }
    it { expect(Order.statuses[:complete]).to eq 5 }
    it { expect(Order.statuses[:in_delivery]).to eq 6 }
    it { expect(Order.statuses[:delivered]).to eq 7 }
    it { expect(Order.statuses[:canceled]).to eq 8 }
  end
end
