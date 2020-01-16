class Credential < ApplicationRecord
  validates :login, presence: true, uniqueness: true
  validates :password, presence: true
  belongs_to :establishment
end
