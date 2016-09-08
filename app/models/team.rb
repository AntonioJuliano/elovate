class Team
  include Mongoid::Document

  has_and_belongs_to_many :entries
  has_many :wins, class_name: "Game", inverse_of: :winner
  has_many :losses, class_name: "Game", inverse_of: :loser

  def games
    wins << losses
  end
end
