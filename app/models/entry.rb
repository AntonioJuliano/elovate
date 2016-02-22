class Entry
  include Mongoid::Document

  field :elo, type: Integer, default: 0

  belongs_to :user
  belongs_to :league
  has_and_belongs_to_many :teams

  validates :league, presence: true

  def record_game
  end


end
