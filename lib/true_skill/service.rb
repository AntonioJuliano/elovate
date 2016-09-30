module TrueSkill
  class Service
    STARTING_MU = 1000.0
    STARTING_SIGMA = 332.0

    class << self
      def update_ratings_for_game(game)
        lock_ratings(game.results.map { |result| result.entry.rating.id }) do
          team_ratings = game.teams.map { |team| team.map { |result| result.entry.rating.to_h } }
          team_results = game.teams.map { |team| team.first.result }

          all_ratings = {}
          game.results.each do |r|
            all_ratings[r.entry.rating.id.to_s] = r.entry.rating
          end

          params = {
            teams: team_ratings,
            results: team_results,
            environment: trueskill_environment
          }

          resp = JSON.parse(client.get_rating_updates(params).body).deep_symbolize_keys!

          unless (resp[:new_ratings].map { |r| r[:id] } - all_ratings.keys).empty?
            raise "TrueSkill did not return new ratings for all passed ratings"
          end

          resp[:new_ratings].each do |new_rating|
            r = all_ratings[new_rating[:id]]
            r.update({ 
              mu: new_rating[:mu],
              sigma: new_rating[:sigma]
            })
          end
        end

        true
      end

      private

      # We need to lock every rating we are about to update
      def lock_ratings(rating_ids, &block)
        if rating_ids.empty?
          block.call
        else
          sorted = rating_ids.sort # sort to prevent against deadlocks
          $redis.lock("update_rating_#{sorted.pop}") do
            lock_ratings(sorted, &block)
          end
        end
      end

      def trueskill_environment
        {
          mu: STARTING_MU,
          sigma: STARTING_SIGMA,
          beta: STARTING_SIGMA / 2,
          tau: STARTING_SIGMA / 100
        }
      end

      def client
        Thread.current[:trueskill_client] ||= TrueSkill::Client.new
      end
    end
  end
end