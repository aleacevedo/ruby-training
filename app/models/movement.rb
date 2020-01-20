class Movement < ApplicationRecord
  enum :provider %i[visa mastercard amex cabal]
  enum :currency %i[usd ars]
end
