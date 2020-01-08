class Account < ApplicationRecord
    validates :name, precense: true
end
