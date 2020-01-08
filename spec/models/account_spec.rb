require 'rails_helper'
require 'faker'

RSpec.describe Account, :type => :model do
  it "is valid with valid attributes" do
    account = Account.new(name: Faker::Company.name)
    expect(account).to be_valid
  end
  it "is not valid without a name" do
    account = Account.new
    expect(account).to_not be_valid
  end
end