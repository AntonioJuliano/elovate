class User
  include Mongoid::Document

  field :username, type: String
  field :elo, type: Integer
end
