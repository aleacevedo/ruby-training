# frozen_string_literal: true

require 'rails_helper'

describe Shop, type: :model do
  let(:account) { create(:account) }
  let(:name) { Faker::Company.name }
  it 'is valid with valid attributes' do
    shop = Shop.new(name: name, account_id: account.id)
    expect(shop).to be_valid
  end
  it 'is not valid without a name' do
    shop = Shop.new(account_id: account.id)
    expect(shop).to_not be_valid
  end
  it 'is not valid without a account id' do
    shop = Shop.new(name: name)
    expect(shop).to_not be_valid
  end
end
