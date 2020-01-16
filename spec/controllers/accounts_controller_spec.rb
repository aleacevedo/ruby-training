# frozen_string_literal: true

require 'rails_helper'

describe AccountsController, type: :controller do
  let!(:accounts) { create_list(:account, 20) }
  let(:admin_user) { create(:user) }
  describe 'GET #index' do
    let!(:accounts) { create_list(:account, 20) }
    before do
      get :index
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'JSON body response contains expected account attributes' do
      expect(response).to match_json_schema('account_array')
    end

    it 'responds with 10 accounts' do
      accounts_responded = response.parsed_body
      expect(accounts_responded.length).to be(10)
    end
  end

  describe 'GET #show' do
    let!(:accounts) { create_list(:account, 20) }
    before do
      get :show, params: { id: accounts[0].id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'JSON body response contains expected account attributes' do
      account_responded = response.parsed_body
      expect(account_responded.keys).to include('id', 'name')
    end
    it 'JSON body response contains match attributes' do
      account_responded = response.parsed_body
      expect(account_responded.keys).to include('id', 'name')
      expect(account_responded['id']).to eq accounts[0][:id]
      expect(account_responded['name']).to eq accounts[0][:name]
    end
  end

  describe 'POST #create' do
    let(:account) { attributes_for :account }
    context 'when user is authenticated' do
      include_context 'with authenticated user'
      before do
        request.headers.merge! default_headers
        post :create, params: { account: account }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'JSON body response match account attributes' do
        expect(response).to match_json_schema('account')
      end
    end
    context 'when user is not authenticated' do
      before do
        post :create, params: { account: account }
      end

      it 'returns http unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PUT #update' do
    let(:account) { create :account }
    let(:new_account) { attributes_for :account }
    context 'when user is authenticated' do
      include_context 'with authenticated user'
      before do
        request.headers.merge! default_headers
        put :update, params: { account: new_account, id: account.id }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'JSON body response match account attributes' do
        get :show, params: { id: account.id }
        account_responded = response.parsed_body
        expect(account_responded['name']).to match(new_account[:name])
      end
    end
    context 'when user is not authenticated' do
      before do
        put :update, params: { account: new_account, id: account.id }
      end

      it 'returns http unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
