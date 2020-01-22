# frozen_string_literal: true

class ClearingsController < ApplicationController
  before_action :authenticate_user!
  def index
    account = current_user.account
    render json: calc_clearing(account), status: :ok
  end

  def calc_clearing(account)
    from = params[:from] || Date.today.beginning_of_month
    to = params[:to] || Date.today.end_of_month
    establishments = Establishment.where(shop: Shop.where(account: account))
    Payment.select(:total_amount)
           .where(establishment: establishments)
           .where('payment_date BETWEEN ? AND ?', from, to)
           .group(:provider)
           .sum(:total_amount)
  end
end
