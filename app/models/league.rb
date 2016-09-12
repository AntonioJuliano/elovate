class League
  include Mongoid::Document

  field :name, type: String
  field :description, type: String

  has_many :entries, autosave: true
  has_many :games

  validates :name, length: {in: 3..20}, presence: true
end
