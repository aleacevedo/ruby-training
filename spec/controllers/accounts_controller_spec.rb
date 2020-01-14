# frozen_string_literal: true

require 'rails_helper'

describe AccountsController, type: :controller do
  let(:account_schema) do
    {
      type: 'object',
      required: %w[id name],
      properties: {
        id: { 'type' => 'integer' },
        name: { 'type' => 'string' }
      }
    }
  end

  describe 'GET #index' do
    let!(:accounts) { create_list(:account, 20) }
    before do
      get :index
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'JSON body response contains expected account attributes' do
      accounts_responded = response.parsed_body
      expect(JSON::Validator.validate(account_schema, accounts_responded,
                                      list: true)).to be true
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
    before do
      post :create, params: { account: account }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'JSON body response match account attributes' do
      account_responded = response.parsed_body
      expect(JSON::Validator.validate(account_schema, account_responded)).to be true
    end
  end

  describe 'PUT #update' do
    let(:account) { create :account }
    let(:new_account) { attributes_for :account }
    before do
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
end
