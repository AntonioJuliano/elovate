class User
  include Mongoid::Document

  field :username, type: String
  field :firstname, type: String
  field :lastname, type: String
  field :password, type: String

  has_many :entries

  validates :username, length: {in: 3..20}, presence: true
  validates :firstname, presence: true, format: {with: /\A[a-zA-Z\-]+\z/, message: "only letters and dashes allowed"}
  validates :lastname, presence: true, format: {with: /\A[a-zA-Z\-]+\z/, message: "only letters and dashes allowed"}


  # User joins a new league. Create new entry and associate the entry with this user and the league.
  def enter_league(league)
    e = Entry.new
    e.user = self
    if league.nil?
      raise 'League does not exist.'
    else
      e.league = league
    end
    e.save!
  end

end
