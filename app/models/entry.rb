class Entry
  include Mongoid::Document

  field :elo, type: Integer

  belongs_to :user
  belongs_to :league
  has_and_belongs_to_many :teams

end
