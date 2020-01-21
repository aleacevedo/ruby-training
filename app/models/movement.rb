# frozen_string_literal: true

class Movement < ApplicationRecord
  enum provider: %i[visa mastercard amex cabal]
  enum currency: %i[usd ars]

  belongs_to :payment
end
