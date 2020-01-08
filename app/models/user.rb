class User < ApplicationRecord
    validates :email, presence: true
    validates :password, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    has_one :account
end
