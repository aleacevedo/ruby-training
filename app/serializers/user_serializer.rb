class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :account
  def account
    {
      id: self.object.account.id,
      name: self.object.account.name
    }
  end
end
