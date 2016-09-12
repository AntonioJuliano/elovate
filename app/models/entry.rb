class Entry
  include Mongoid::Document

  field :elo, type: Integer, default: 0
  field :manager, type: Boolean, default: false

  field :name
  # TODO permissions

  belongs_to :user
  belongs_to :league
  has_many :results

  validates :name, length: {in: 3..20}, presence: true
  validates_presence_of :league, :user, :elo
  validate :validate_unique_name, on: :create
  validate :validate_unique_per_user, on: :create

  def games
    results.map { |r| r.game }
  end

  private

  def validate_unique_name
    if Entry.where(name: name, league: league).length > 0
      errors.add(:name, 'Already taken')
    end
  end

  def validate_unique_per_user
    if Entry.where(user: user, league: league).length > 0
      errors.add(:league, 'User already in league')
    end
  end
end
