# frozen_string_literal: true

require 'rails_helper'

describe Payment, type: :model do
  let(:payment_attrs) { attributes_for :payment }
  let(:establishment) { create :establishment }

  before { payment_attrs.merge!(establishment_id: establishment.id) }

  it 'is valid with valid attributes' do
    payment = Payment.new(payment_attrs)
    expect(payment).to be_valid
  end

  it 'is not valid with not valid provider' do
    payment_attrs['provider'] = Faker::Number.between(from: 4, to: 100)
    expect { Payment.new(payment_attrs) }.to raise_error(ArgumentError)
  end

  it 'is not valid with not valid document_type' do
    payment_attrs['document_type'] = Faker::Number.between(from: 3, to: 100)
    expect { Payment.new(payment_attrs) }.to raise_error(ArgumentError)
  end

  it 'is not valid with not valid currency' do
    payment_attrs['currency'] = Faker::Number.between(from: 2, to: 100)
    expect { Payment.new(payment_attrs) }.to raise_error(ArgumentError)
  end

  context 'when opening_balance is different than closing_balance' do
    before { payment_attrs[:opening_balance] = (payment_attrs[:closing_balance] + 1) }
    it 'is balanced false' do
      payment = Payment.create(payment_attrs)
      expect(payment.is_balanced).to be false
    end
  end

  context 'when opening_balance is the same as closing_balance' do
    before { payment_attrs[:closing_balance] = payment_attrs[:opening_balance] }
    it 'is balanced true' do
      payment = Payment.create(payment_attrs)
      expect(payment.is_balanced).to be true
    end
  end

  context 'when payment alredy exist' do
    let(:payment) { create(:payment) }
    before { payment_attrs['clearing_number'] = payment.clearing_number }

    it 'is not valid with not valid provider' do
      expect(Payment.new(payment_attrs)).to_not be_valid
    end
  end
end
