class User
  include Mongoid::Document

  field :username, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :password, type: String

  has_many :entries

  validates :username, length: {in: 3..20}, presence: true, uniqueness: true
  validates :first_name, presence: true,
    format: {with: /\A[a-zA-Z\-]+\z/, message: "only letters and dashes allowed"}
  validates :last_name, presence: true,
    format: {with: /\A[a-zA-Z\-]+\z/, message: "only letters and dashes allowed"}

  # User joins a new league.
  # Create new entry and associate the entry with this user and the league.
  def enter_league(league)
    e = Entry.create(
      user: self,
      league: league,
    )
  end

  def leagues
    ls = []
    entries.order_by(:created_at => :desc).each do |e|
      ls << e.league
    end
    ls
  end
end
