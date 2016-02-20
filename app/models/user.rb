class User
  include Mongoid::Document

  field :username, type: String
  field :firstname, type: String
  field :lastname, type: String
  field :password, type: String

  has_many :entrys
end
