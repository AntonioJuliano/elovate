class Game
  include Mongoid::Document

  field :data, type: Hash, default: {}

  belongs_to :winner, class_name: "Team", inverse_of: :wins
  belongs_to :loser, class_name: "Team", inverse_of: :losses

  validates_presence_of :winner, :loser

  after_create :update_elo

  def update_elo
    
  end
end
