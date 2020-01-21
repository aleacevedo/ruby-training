# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe 'GET #index' do
    before do
      request.headers.merge! default_headers
    end
    context 'when user is authenticated' do
      include_context 'with authenticated user'

      before :all do
        Timecop.freeze(Date.parse('2020-01-31'))
        shop = create(:shop)
        establishment = create(:establishment, shop: shop)
        (Date.today.at_beginning_of_month...Date.today.at_end_of_month + 2).each do |date|
          payments = create_list(:payment,
                                 5,
                                 total_amount: 1,
                                 origin_date: date - 1,
                                 payment_date: date,
                                 establishment: establishment)
          transactions = create_list(:transaction,
                                     5,
                                     amount: 1,
                                     origin_date: date - 1,
                                     payment_date: date,
                                     payment: payments[0])
          refunds = create_list(:refund,
                                20,
                                amount: 1,
                                origin_date: date - 1,
                                payment_date: date,
                                payment: payments[0])
          chargeback = create_list(:chargeback,
                                   10,
                                   amount: 1,
                                   origin_date: date - 1,
                                   payment_date: date,
                                   payment: payments[0])
        end
      end

      before do
        Shop.last.update(account: admin_user.account)
        get :index
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'JSON body response contains expected dashboard attributes' do
        expect(response).to match_json_schema('dashboard')
      end

      it 'responds with right today_amount' do
        dashboard_responder = response.parsed_body
        expect(dashboard_responder['today_amount']).to eq('5.0')
      end

      it 'responds with right tomorrow_amount' do
        dashboard_responder = response.parsed_body
        expect(dashboard_responder['tomorrow_amount']).to eq('5.0')
      end

      it 'responds with right chargeback_refund' do
        dashboard_responder = response.parsed_body
        expect(dashboard_responder['chargeback_refunds']).to eq('30.0')
      end

      it 'responds with right month' do
        month = response.parsed_body['month']
        month.each do |day|
          expect(day[1]['payment_amount']).to eq('5.0')
          expect(day[1]['transaction_count']).to eq(5)
        end
      end

      it 'responds with right month' do
        month = response.parsed_body['month']
        expect(month.length).to be(Time.days_in_month(Date.today.month))
      end
    end
    context 'when user not is authenticated' do
      let(:default_headers) { {} }

      before do
        get :index
      end

      it 'returns http success' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
