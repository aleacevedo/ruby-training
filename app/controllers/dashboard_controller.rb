# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: {
      today_amount: calc_payment_amount_of(Date.today),
      tomorrow_amount: calc_payment_amount_of(Date.tomorrow),
      chargeback_refunds: calc_chargeback_and_refunds,
      month: generate_month
    }, status: 200
  end

  private

  def calc_payment_amount_of(date)
    Payment.where(establishment: establishments)
           .where(payment_date: date).sum(&:total_amount)
  end

  def calc_chargeback_and_refunds
    Movement.where(payment: Payment.where(establishment: establishments))
            .where(payment_date: Date.today)
            .where('type=? OR type=?', 'Chargeback', 'Refund')
            .sum(&:amount)
  end

  def generate_month
    month = {}
    payments = generate_month_summary_payments
    transactions = generate_month_summary_transactions
    payments.keys.union(transactions.keys).each do |key|
      month[key] = { payment_amount: payments[key], transaction_count: transactions[key] }
    end
    month
  end

  def generate_month_summary_payments
    Payment.select(:payment_date)
           .where(establishment: establishments)
           .where('EXTRACT(MONTH FROM payment_date) = ?', Date.today.month)
           .group('date(payment_date)')
           .sum(:total_amount)
  end

  def generate_month_summary_transactions
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
