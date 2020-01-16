require 'rails_helper'

describe Establishment, type: :model do
  let(:shop) { create :shop }
  let(:number) { Faker::Number.number(digits: 20).to_s }
  it 'is valid with attributes' do
    establishment = Establishment.create(number: number, shop_id: shop.id)
    expect(establishment).to be_valid
  end

  it 'is not valid without number' do
    establishment = Establishment.create(shop_id: shop.id)
    expect(establishment).to_not be_valid
  end

  it 'is not valid without shop_id' do
    establishment = Establishment.create(number: number)
    expect(establishment).to_not be_valid
  end
end
