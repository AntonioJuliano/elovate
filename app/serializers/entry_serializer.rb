class EntrySerializer < ActiveModel::Serializer
  attributes :name, :rating, :id, :league_id

  has_one :rating

  def id
    object.id.to_s
  end

  def rating
    object.rating.mu
  end

  def league_id
    object.league.id.to_s
  end
end
