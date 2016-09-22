class ResultSerializer < ActiveModel::Serializer
  attributes :id, :name, :rating, :team, :result
  # belongs_to :entry, serializer: EntrySerializer

  def name
    object.entry.name
  end

  def rating
    object.entry.rating.mu
  end

  def id
    object.entry.id.to_s
  end
end
