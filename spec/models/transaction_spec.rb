require 'rails_helper'

RSpec.describe Transaction, type: :model do

  let(:transaction_attrs) { attributes_for :transaction }
  
  it_behaves_like 'a movement'

  it 'valid with valid transaction attributes' do
    transaction = Transaction.new(transaction_attrs)
    expect(transaction).to be_valid
  end

  it 'not valid with no installments current' do
    transaction_attrs[:installments_current] = nil
    transaction = Transaction.new(transaction_attrs)
    expect(transaction).to_not be_valid
  end

  it 'not valid with no installments number' do
    transaction_attrs[:installments_number] = nil
    transaction = Transaction.new(transaction_attrs)
    expect(transaction).to_not be_valid
  end

  it 'not valid with no installments total' do
    transaction_attrs[:installments_total] = nil
    transaction = Transaction.new(transaction_attrs)
    expect(transaction).to_not be_valid
  end
end
