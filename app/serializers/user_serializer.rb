class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :first_name, :last_name
  has_many :entries

  def id
    object.id.to_s
  end
end
