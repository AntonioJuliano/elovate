class League
  include Mongoid::Document

  field :league, type: String

  has_many :entries
end
