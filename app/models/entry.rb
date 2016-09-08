class Entry
  include Mongoid::Document

  field :elo, type: Integer, default: 0
  field :manager, type: Boolean, default: false

  belongs_to :user
  belongs_to :league
  has_and_belongs_to_many :teams

  validates_presence_of :league, :user, :elo

  def record_game
  end


end
