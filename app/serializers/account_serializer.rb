# frozen_string_literal: true

class AccountSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :users
end
