require 'rails_helper'

describe User, type: :model do
  let (:account) {FactoryGirl.create :account}
  let (:email) {Faker::Internet.email}
  let (:password) {Faker::Alphanumeric.alpha(number: 10)}
  let (:first_name) {Faker::Name.first_name}
  let (:last_name) {Faker::Name.last_name}
  it "is valid with attributes" do
    user = account.users.create(email: email, password: password, first_name: first_name, last_name: last_name)
    expect(user).to be_valid
  end
  it "is not valid without email" do
    user = account.users.create(email: nil, password: password, first_name: first_name, last_name: last_name)
    expect(user).to_not be_valid
  end
  it "is not valid without password" do
    user = account.users.create(email: email, password: nil, first_name: first_name, last_name: last_name)
    expect(user).to_not be_valid
  end
  it "is not valid without first name" do
    user = account.users.create(email: email, password: password, first_name: nil, last_name: last_name)
    expect(user).to_not be_valid
  end
  it "is not valid without last name" do
    user = account.users.create(email: email, password: password, first_name: first_name, last_name: nil)
    expect(user).to_not be_valid
  end
end
