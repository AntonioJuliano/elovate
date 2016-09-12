class LeagueSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_many :entries

  def id
    object.id.to_s
  end
end
