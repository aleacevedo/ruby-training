# frozen_string_literal: true

class Account < ApplicationRecord
  validates :name, presence: true
  has_many :users, dependent: :destroy
  has_many :shops, dependent: :delete_all
end
