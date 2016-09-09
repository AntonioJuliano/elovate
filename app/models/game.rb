class Game
  include Mongoid::Document

  field :data, type: Hash, default: {}

  has_many :results, autosave: true
  belongs_to :league

  validates_presence_of :league
  validate :validate_results

  after_create :update_elo

  def self.generate(league, params)
    new_game = Game.new
    new_game.data = params[:data].to_h
    new_game.league = league

    # Initialize results
    results = []
    params[:teams].each_with_index do |r, i|
      next unless r[:members]
      r[:members].each do |e|
        new_result = Result.new(
          game: new_game,
          entry: Entry.where(league: league, name: e).first,
          result: r[:result],
          team: i
        )
        results << new_result
      end
    end

    new_game.results = results

    new_game.save

    new_game
  end

  def update_elo
    
  end

  private

  def validate_results
    unless results.map { |r| r.team }.uniq.length >= 2
      errors.add(:results, 'Game must have at least 2 distinct teams')
    end

    results_map = {}
    results.each do |r|
      results_map[r.team] ||= r.result
      if results_map[r.team] != r.result
        errors.add(:results, 'Results of same team must have same result')
        return
      end
    end
  end
end
