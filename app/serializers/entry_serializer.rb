class EntrySerializer < ActiveModel::Serializer
  attributes :name, :elo, :id

  def id
    object.id.to_s
  end
end
