require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe 'GET #index' do
    before do
      request.headers.merge! default_headers
    end
    context 'when user is authenticated' do
      include_context 'with authenticated user'

      before :all do
        Timecop.freeze(Date.parse('2019-01-31'))
        shop = create(:shop)
        establishment = create(:establishment, shop: shop)
        (Date.today.at_beginning_of_month - 2...Date.today.at_end_of_month).each do |date|
          payments = create_list(:payment,
                                5,
                                total_amount: 1,
                                origin_date: date,
                                payment_date: date + 2,
                                establishment: establishment)
          transactions = create_list(:transaction,
                                    5,
                                    amount: 1,
                                    origin_date: date,
                                    payment_date: date + 2,
                                    payment: payments[0])
          refunds = create_list(:refund,
                                5,
                                amount: 1,
                                origin_date: date,
                                payment_date: date + 2,
                                payment: payments[0])
          chargeback = create_list(:chargeback,
                                  5,
                                  amount: 1,
                                  origin_date: date,
                                  payment_date: date + 2,
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

      it 'responds with right today_amount', :focus => true do
        dashboard_responder = response.parsed_body
        expect(dashboard_responder["today_amount"]).to eq("5.0")
      end
    end
  end
end
