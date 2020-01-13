class AccountSerializer < ActiveModel::Serializer
  attributes :id, :name, :users
  def users
    self.object.users.map do |user|
      {
        first_name: user.first_name,
        last_name: user.last_name,
        emai: user.email
      }
    end
  end
end
