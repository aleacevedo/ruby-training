# frozen_string_literal: true

class Payment < ApplicationRecord
  enum provider: %i[visa mastercard amex cabal]
  enum document_type: %i[pdf txt csv]
  enum currency: %i[usd ars]

  belongs_to :establishment
  has_many :movements

  validates :clearing_number, presence: true, uniqueness: true

  before_save :check_is_balanced

  private

  def check_is_balanced
    self.is_balanced = (opening_balance == closing_balance)
  end
end
