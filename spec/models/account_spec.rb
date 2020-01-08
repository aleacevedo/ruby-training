require 'rails_helper'

describe Account, type: :model do
  let(:name) { Faker::Company.name }
  it "is valid with valid attributes" do
    account = Account.new(name: name)
    expect(account).to be_valid
  end
  it "is not valid without a name" do
    account = Account.new
    expect(account).to_not be_valid
  end
end
