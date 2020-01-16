# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    name { Faker::Company.name }
  end
end

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Alphanumeric.alpha(number: 10) }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    account
  end
end

FactoryBot.define do
  factory :shop do
    name { Faker::Company.name }
    address { Faker::Address.full_address }
  end
end

FactoryBot.define do
  factory :establishment do
    number { Faker::Number.number.to_s }
  end
end
