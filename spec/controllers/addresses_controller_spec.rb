require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  let(:user) { create(:user) }
  let(:order) { create(:order, user_id: user.id) }

  # before do
  #   sign_in user
  #   allow(subject).to receive(:current_user).and_return
  #   allow(subject).to receive(:current_order).and_return
  # end
  #
  #
  # describe 'POST #create' do
  #   #
  #   # it 'success' do
  #   #   post :create, params: { id: user.id,  }
  #   # end
  #
  #   # it 'failed' do
  #   #   post :create, params: { id: user.id }
  #   #   expect(response).to render_template('settings/new')
  #   # end
  # end
end
