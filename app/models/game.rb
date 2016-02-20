class Game
  include Mongoid::Document

  field :p1, type: String
  field :p2, type: String
  field :winner, type: String

  belongs_to :team1, class_name: 'Team'
  belongs_to :team2, class_name: 'Team'

end
