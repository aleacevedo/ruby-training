FactoryBot.define do
  factory :credential do
    login { Faker::Internet.username(specifier: 8) }
    password { Faker::Alphanumeric.alpha(number: 10) }
  end
end
