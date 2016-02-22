class Team
  include Mongoid::Document

  field :winner, type: String

  has_and_belongs_to_many :team_one, class_name: Entry
  has_and_belongs_to_many :team_two, class_name: Entry
  has_many :games

end
