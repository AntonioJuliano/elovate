class Rating
  include Mongoid::Document

  field :mu, type: Float, default: TrueSkill::Service::STARTING_MU
  field :sigma, type: Float, default: TrueSkill::Service::STARTING_SIGMA

  belongs_to :entry

  validates_presence_of :entry, :mu, :sigma

  def to_h
    {
      id: id.to_s,
      mu: mu,
      sigma: sigma
    }
  end
end
