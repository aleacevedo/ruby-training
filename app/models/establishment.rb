# frozen_string_literal: true

class Establishment < ApplicationRecord
  belongs_to :shop
  belongs_to :credential
  has_many :payments

  validates :number, presence: true, uniqueness: true
end
