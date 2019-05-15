require 'rails_helper'

RSpec.describe User, type: :model do
  context 'with database columns' do
    it { is_expected.to have_db_column(:email).of_type(:string).with_options(default: '', null: false) }
    it { is_expected.to have_db_column(:encrypted_password).of_type(:string).with_options(default: '', null: false) }
    it { is_expected.to have_db_column(:reset_password_token).of_type(:string) }
  end

  context 'with assosiations' do
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:addresses).dependent(:destroy) }
    it { is_expected.to have_many(:orders).dependent(:destroy) }
  end
end
