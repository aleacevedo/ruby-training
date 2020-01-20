# frozen_string_literal: true

FactoryBot.define do
  factory :refund do
    payment_date { Faker::Date.backward(days: 365) }
    origin_date { Faker::Date.backward(days: 365) }
    provider { Faker::Number.between(from: 0, to: 3) }
    amount { Faker::Number.decimal }
    currency { Faker::Number.between(from: 0, to: 1) }
    payment
    card_number { Faker::Number.number(digits: 16).to_str }
    coupon_number { Faker::Number.number(digits: 6).to_str }
  end
end
