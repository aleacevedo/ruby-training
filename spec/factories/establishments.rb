FactoryBot.define do
  factory :establishment do
    number { Faker::Number.number.to_s }
    shop
  end
end
