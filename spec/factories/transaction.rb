# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    payment_date { Faker::Date.backward(days: 365) }
    origin_date { Faker::Date.backward(days: 365) }
    provider { Faker::Number.between(from: 0, to: 3) }
    amount { Faker::Number.decimal }
    currency { Faker::Number.between(from: 0, to: 1) }
    payment
    installments_current { Faker::Number.number }
    installments_number { Faker::Number.number }
    installments_total { Faker::Number.number }
    card_number { Faker::Number.number(digits: 16).to_s }
    discount_amount { Faker::Number.decimal }
  end
end
