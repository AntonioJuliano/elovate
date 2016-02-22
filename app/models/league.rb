class League
  include Mongoid::Document

  field :name, type: String
  field :description, type: String

  has_many :entries

  validates_presence_of :name

end
