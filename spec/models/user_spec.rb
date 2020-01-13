# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  let (:account) {create :account}
  let (:email) {Faker::Internet.email}
  let (:password) {Faker::Alphanumeric.alpha(number: 10)}
  let (:first_name) {Faker::Name.first_name}
  let (:last_name) {Faker::Name.last_name}
  it "is valid with attributes" do
    user = User.create(email: email, password: password, first_name: first_name, last_name: last_name, account_id: account.id)
    expect(user).to be_valid
  end
  it 'is not valid without email' do
    user = User.create(email: nil,
                       password: password,
                       first_name: first_name,
                       last_name:
                       last_name,
                       account_id: account.id)
    expect(user).to_not be_valid
  end
  it 'is not valid without password' do
    user = User.create(email: email,
                       password: nil,
                       first_name: first_name,
                       last_name: last_name,
                       account_id: account.id)
    expect(user).to_not be_valid
  end
  it 'is not valid without first name' do
    user = User.create(email: email,
                       password: password,
                       first_name: nil,
                       last_name: last_name,
                       account_id: account.id)
    expect(user).to_not be_valid
  end
  it 'is not valid without last name' do
    user = User.create(email: email,
                       password: password,
                       first_name: first_name,
                       last_name: nil,
                       account_id: account.id)
    expect(user).to_not be_valid
  end
  it 'is not valid without account id' do
    user = User.create(email: email,
                       password: password,
                       first_name: first_name,
                       last_name: last_name,
                       account_id: nil)
    expect(user).to_not be_valid
  end
  it 'is not valid with not unique email' do
    first_user = User.create(email: email,
                             password: password,
                             first_name: first_name,
                             last_name: last_name,
                             account_id: account.id)
    last_user = User.create(email: email,
                            password: password,
                            first_name: first_name,
                            last_name: last_name,
                            account_id: account.id)
    expect(first_user).to be_valid
    expect(last_user).to_not be_valid
  end
end
