FactoryBot.define do
  factory :payment do
    payment_date { Faker::Date.backward(days: 365) }
    origin_date { Faker::Date.backward(days: 365) }
    provider { Faker::Number.between(from: 0, to: 3) }
    document_type { Faker::Number.between(from: 0, to: 2) }
    clearing_number { Faker::Number.number(digits: 5) }
    total_amount { Faker::Number.decimal }
    total_deduction { Faker::Number.decimal }
    total_earn { Faker::Number.decimal }
    opening_balance { Faker::Number.decimal }
    closing_balance { Faker::Number.decimal }
    currency { Faker::Number.between(from: 0, to: 1) }
    establishment
  end
end
