class Payment < ApplicationRecord
  enum provider: %i[visa mastercard amex cabal]
  enum document_type: %i[pdf txt csv]
  enum currency: %i[usd ars]

  belongs_to :establishment

  validates :clearing_number, presence: true, uniqueness: true
end
