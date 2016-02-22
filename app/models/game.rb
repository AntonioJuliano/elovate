class Game
  include Mongoid::Document

  field :winner, type: String

  belongs_to :team1, class_name: Team
  belongs_to :team2, class_name: Team

  def update_elo

  end

end
