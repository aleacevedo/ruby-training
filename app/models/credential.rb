# frozen_string_literal: true

class Credential < ApplicationRecord
  validates :login, presence: true, uniqueness: true
  validates :password, presence: true
  has_many :establishments, dependent: :destroy
end
