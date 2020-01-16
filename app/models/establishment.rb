# frozen_string_literal: true

class Establishment < ApplicationRecord
  belongs_to :shop

  validates :number, presence: true, uniqueness: true
end
