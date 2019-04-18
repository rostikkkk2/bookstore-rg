require 'rails_helper'

RSpec.describe Address, type: :model do
  context 'with database columns' do
    it { is_expected.to have_db_column(:first_name).of_type(:string) }
    it { is_expected.to have_db_column(:last_name).of_type(:string) }
    it { is_expected.to have_db_column(:address).of_type(:string) }
    it { is_expected.to have_db_column(:city).of_type(:string) }
    it { is_expected.to have_db_column(:zip).of_type(:integer) }
    it { is_expected.to have_db_column(:country).of_type(:string) }
    it { is_expected.to have_db_column(:phone).of_type(:string) }
    it { is_expected.to have_db_column(:address_type).of_type(:integer) }
    it { is_expected.to have_db_column(:resource_id).of_type(:integer).with_options(index: true) }
    it { is_expected.to have_db_column(:resource_type).of_type(:string).with_options(index: true) }
  end

  context 'with assosiations' do
    it { is_expected.to belong_to(:resource) }
  end

  context 'with enum types' do
    it { expect(Address.address_types[:billing]).to eq 0 }
    it { expect(Address.address_types[:shipping]).to eq 1 }
  end
end
