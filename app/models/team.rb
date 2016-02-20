class Team
  include Mongoid::Document

  field :p1, type: String
  field :p2, type: String
  field :winner, type: String

  has_and_belongs_to_many :entries
  has_many :games

end
