class Team
  include Mongoid::Document

  has_and_belongs_to_many :team_one, class_name: Entry
  has_and_belongs_to_many :team_two, class_name: Entry
  has_many :games

end
