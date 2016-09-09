class GameSerializer < ActiveModel::Serializer
  attributes :id, :data
  belongs_to :league
  has_many :results

  def id
    object.id.to_s
  end
end
