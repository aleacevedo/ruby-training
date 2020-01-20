class Movement < ApplicationRecord
  enum :provider %i[visa mastercard amex cabal]
  enum :currency %i[usd ars]

  validates :installments_current,
            :installments_current,
            :installments_total,
            presence: true,
            if: :any_installments?

  def any_installments?
    installments = [self[:installments_current],
                    self[:installments_number],
                    self[:installments_total]]
    installments.any(&:present?)
  end
end
