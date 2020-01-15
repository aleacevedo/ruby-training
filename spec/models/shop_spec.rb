require 'rails_helper'

describe Shop, type: :model do
  let(:name) { Faker::Company.name }
  it 'is valid with valid attributes' do
    account = Shop.new(name: name)
    expect(account).to be_valid
  end
  it 'is not valid without a name' do
    account = Shop.new
    expect(account).to_not be_valid
  end
end
