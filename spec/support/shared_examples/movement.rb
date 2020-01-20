# frozen_string_literal: true

shared_examples 'a movement' do
  let(:movement_attrs) { attributes_for :movement }
  it 'valid with valid attributes' do
    tested_class = described_class.create(movement_attrs)
    expect(tested_class).to be_valid
  end

  it 'is not valid with not valid provider' do
    movement_attrs['provider'] = Faker::Number.between(from: 4, to: 100)
    expect { described_class.create(movement_attrs) }.to raise_error(ArgumentError)
  end

  it 'is not valid with not valid currency' do
    movement_attrs['currency'] = Faker::Number.between(from: 2, to: 100)
    expect { described_class.create(movement_attrs) }.to raise_error(ArgumentError)
  end
end
