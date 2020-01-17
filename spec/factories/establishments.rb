# frozen_string_literal: true

FactoryBot.define do
  factory :establishment do
    number { Faker::Number.number.to_s }
    shop
  end
end
