# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClearingsController, type: :controller do
  describe 'GET #index' do
    let(:shop) { create(:shop) }
    let(:establishment) { create(:establishment, shop: shop) }
    let!(:payments_visa_today) do
      create_list(:payment, 2,
                  total_amount: 1,
                  payment_date: Date.today,
                  provider: 0,
                  establishment: establishment)
    end
    let!(:payments_master_today) do
      create_list(:payment, 4,
                  total_amount: 1,
                  payment_date: Date.today,
                  provider: 1,
                  establishment: establishment)
    end
    let!(:payments_amex_today) do
      create_list(:payment, 6,
                  total_amount: 1,
                  payment_date: Date.today,
                  provider: 2,
                  establishment: establishment)
    end
    let!(:payments_cabal_today) do
      create_list(:payment, 8,
                  total_amount: 1,
                  payment_date: Date.today,
                  provider: 3,
                  establishment: establishment)
    end
    let!(:payments_visa_five_days) do
      create_list(:payment, 2,
                  total_amount: 1,
                  payment_date: Date.today + 5,
                  provider: 0,
                  establishment: establishment)
    end
    let!(:payments_master_five_days) do
      create_list(:payment, 4,
                  total_amount: 1,
                  payment_date: Date.today + 5,
                  provider: 1,
                  establishment: establishment)
    end
    let!(:payments_amex_five_days) do
      create_list(:payment, 6,
                  total_amount: 1,
                  payment_date: Date.today + 5,
                  provider: 2,
                  establishment: establishment)
    end
    let!(:payments_cabal_five_days) do
      create_list(:payment, 8,
                  total_amount: 1,
                  payment_date: Date.today + 5,
                  provider: 3,
                  establishment: establishment)
    end
    before { request.headers.merge! default_headers }
    context 'when user is authenticated' do
      include_context 'with authenticated user'
      before do
        shop.update(account: admin_user.account)
        get :index
      end
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
      it 'JSON body response contains expected clearings attributes' do
        expect(response).to match_json_schema('clearing')
      end
      context 'when filter is set' do
        before { get :index }
        it 'value are right' do
          parsed_body = response.parsed_body
          expect(parsed_body['visa']).to eq('4.0')
          expect(parsed_body['mastercard']).to eq('8.0')
          expect(parsed_body['amex']).to eq('12.0')
          expect(parsed_body['cabal']).to eq('16.0')
        end
      end
      context 'when filter is not set' do
        before { get :index, params: { from: Date.today - 3, to: Date.today + 3 } }
        it 'value are right' do
          parsed_body = response.parsed_body
          expect(parsed_body['visa']).to eq('2.0')
          expect(parsed_body['mastercard']).to eq('4.0')
          expect(parsed_body['amex']).to eq('6.0')
          expect(parsed_body['cabal']).to eq('8.0')
        end
      end
    end
    context 'when user is not authenticated' do
      let(:default_headers) { {} }
      before do
        get :index
      end
      it 'returns http unhautorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
