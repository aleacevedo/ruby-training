# frozen_string_literal: true

class Transaction < Movement
  validates :installments_current,
            :installments_number,
            :installments_total,
            presence: true,
            if: :any_installments?

  def any_installments?
    installments = [self[:installments_current],
                    self[:installments_number],
                    self[:installments_total]]
    installments.any?(&:present?)
  end
end
