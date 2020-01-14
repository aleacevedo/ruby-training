# frozen_string_literal: true

class Account < ApplicationRecord
  validates :name, presence: true
  has_many :users, dependent: :destroy
end
