FactoryBot.define do
  factory :shop do
    name { Faker::Company.name }
    address { Faker::Address.full_address }
    account
  end
end
