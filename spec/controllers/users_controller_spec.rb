# frozen_string_literal: true

require 'rails_helper'

describe UsersController, type: :controller do
  let(:user_schema) do
    {
      type: 'object',
      required: %w[id email first_name last_name],
      properties: {
        id: { type: 'integer' },
        email: { type: 'string' },
        first_name: { type: 'string' },
        last_name: { type: 'string' },
        account: {
          type: 'object',
          properties: {
            id: { type: 'integer' },
            name: { type: 'string' }
          }
        }
      }
    }
  end

  let(:user_array_schema) do
    {
      tye: 'array',
      items: user_schema
    }
  end

  describe 'GET #index' do
    let!(:users) { create_list(:user, 20) }
    before do
      get :index
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'JSON body response contains expected account attributes' do
      expect(response).to match_json_schema(user_array_schema)
    end

    it 'responds with 10 users' do
      users_responded = response.parsed_body
      expect(users_responded.length).to be(10)
    end
  end

  describe 'GET #show' do
    let!(:users) { create_list(:user, 20) }
    before do
      get :show, params: { id: users[0].id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'JSON body response contains expected account attributes' do
      expect(response).to match_json_schema(user_schema)
    end

    it 'JSON body response contains match attributes' do
      user_responded = response.parsed_body
      expect(user_responded['id']).to eq users[0][:id]
      expect(user_responded['first_name']).to eq users[0][:first_name]
      expect(user_responded['last_name']).to eq users[0][:last_name]
      expect(user_responded['email']).to eq users[0][:email]
    end
  end

  describe 'POST #create' do
    let(:account) { create :account }
    let(:admin_user) { create :user }
    let(:user) { attributes_for :user }
    context 'when user is authenticated' do
      include_context 'with authenticated user'
      before do
        user.merge!(account_id: account.id)
        request.headers.merge! default_headers
        post :create, params: { user: user }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'JSON body response match account attributes' do
        expect(response).to match_json_schema(user_schema)
      end
    end
    context 'when user is not authenticated' do
      before do
        user.merge!(account_id: account.id)
        post :create, params: { user: user }
      end

      it 'returns http unhautorized' do
        expect(response).to have_http_status(:unauthorized)
      end

    end
  end

  describe 'PUT #update' do
    let(:user) { create :user }
    let(:new_user) { attributes_for :user }
    context 'when user is authenticated' do
      include_context 'with authenticated user'
      before do
        request.headers.merge! default_headers
        put :update, params: { user: new_user, id: user.id }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'JSON body response match account attributes' do
        get :show, params: { id: user.id }
        user_responded = response.parsed_body
        expect(user_responded['email']).to match(new_user[:email])
      end
    end
    context 'when user is not authenticated' do
      before do
        put :update, params: { user: new_user, id: user.id }
      end

      it 'returns http unhautorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST #generate_token' do
    let(:user) { create :user }
    before do
      post :generate_token, params:
      {
        email: user.email,
        password: user.password
      }
    end

    it 'return http success with valid email and password' do
      expect(response).to have_http_status(:success)
    end

    it 'token payload is correct' do
      decoded_token = JWT.decode response.parsed_body['token'], nil, false
      expect(decoded_token[0]['data']['user_email']).to match(user.email)
    end

    it 'return http succes with not valid email and password' do
      post :generate_token, params:
      {
        email: user.email,
        password: ('wrong' + user.password)
      }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
