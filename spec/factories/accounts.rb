# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    name { Faker::Company.name }
  end
end
