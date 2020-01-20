class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    account = current_user.account
    render json: {
      today_amount: calc_today_amount(account)
    }, status: 200
  end

  private

  def calc_today_amount(account)
    establishments = Establishment.where(shop: Shop.where(account: account))
    Payment.where(establishment: establishments)
           .where(payment_date: Date.today).sum(&:total_amount)
  end
end
