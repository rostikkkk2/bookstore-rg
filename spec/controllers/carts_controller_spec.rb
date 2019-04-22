require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:order) { create(:order) }

  describe 'GET #index' do
    before do
      get :index
    end

    it { expect(response).to have_http_status(:success) }
  end
end
