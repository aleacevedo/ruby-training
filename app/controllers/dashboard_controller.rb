# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    account = current_user.account
    render json: {
      today_amount: calc_payment_amount_of(account, Date.today),
      tomorrow_amount: calc_payment_amount_of(account, Date.tomorrow),
      chargeback_refunds: calc_chargeback_and_refunds(account),
      month: generate_month(account)
    }, status: 200
  end

  private

  def calc_payment_amount_of(_account, date)
    Payment.where(establishment: establishments)
           .where(payment_date: date).sum(&:total_amount)
  end

  def calc_chargeback_and_refunds(_account)
    Movement.where(payment: Payment.where(establishment: establishments))
            .where(payment_date: Date.today)
            .where('type=? OR type=?', 'Chargeback', 'Refund')
            .sum(&:amount)
  end

  def generate_month(account)
    month = {}
    payments = generate_month_summary_payments(account)
    transactions = generate_month_summary_transactions(account)
    payments.keys.union(transactions.keys).each do |key|
      month[key] = { payment_amount: payments[key], transaction_count: transactions[key] }
    end
    month
  end

  def generate_month_summary_payments(_account)
    Payment.select(:payment_date)
           .where(establishment: establishments)
           .where('EXTRACT(MONTH FROM payment_date) = ?', Date.today.month)
           .group('date(payment_date)')
           .sum(:total_amount)
  end

  def generate_month_summary_transactions(_account)
    Movement.select(:origin_date)
            .where(payment: Payment.where(establishment: establishments))
            .where(type: 'Transaction')
            .where('EXTRACT(MONTH FROM origin_date) = ?', Date.today.month)
            .group(:origin_date)
            .count
  end

  def establishments
    @establishments ||= Establishment.where(shop: Shop.where(account: current_user.account))
  end
end
