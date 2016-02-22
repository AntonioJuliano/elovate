class Game
  include Mongoid::Document

  VALID_WINNERS = ['team_one', 'team_two', 'tie']

  field :winner, type: String

  belongs_to :team1, class_name: Team
  belongs_to :team2, class_name: Team

  validates :winner, inclusion: {in: VALID_WINNERS, message: 'Winner is not valid'}
  def update_elo

  end

end
