class ResultSerializer < ActiveModel::Serializer
  attributes :id, :name, :elo, :team, :result
  # belongs_to :entry, serializer: EntrySerializer

  def name
    object.entry.name
  end

  def elo
    object.entry.elo
  end

  def id
    object.entry.id.to_s
  end
end
