# frozen_string_literal: true

class Shop < ApplicationRecord
  validates :name, presence: true
  belongs_to :account, optional: false
end
