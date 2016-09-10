class EntrySerializer < ActiveModel::Serializer
  attributes :name, :elo, :id, :league_id

  def id
    object.id.to_s
  end

  def league_id
    object.league.id.to_s
  end
end
