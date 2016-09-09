class Result
  include Mongoid::Document

  field :team, type: Integer
  field :result, type: Integer

  belongs_to :entry
  belongs_to :game

  validates_presence_of :team, :result, :entry, :game
end
