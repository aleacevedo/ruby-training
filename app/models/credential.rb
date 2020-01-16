class Credential < ApplicationRecord
  validates :login, presence: true, uniqueness: true
  validates :password, presence: true
  has_many :establishments_credentials,
           class_name: 'Associations::EstablishmentsCredential',
           dependent: :delete_all
  has_many :establishments,
           through: :establishments_credentials,
           dependent: :destroy
end
