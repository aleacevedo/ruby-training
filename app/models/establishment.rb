# frozen_string_literal: true

class Establishment < ApplicationRecord
  belongs_to :shop
  belongs_to :credential

  validates :number, presence: true, uniqueness: true
end
