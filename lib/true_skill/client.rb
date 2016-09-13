module TrueSkill
  class Client
    attr_reader :conn

    def initialize
      @conn = make_connection
    end

    def get_rating_updates(params)
      Retryable.retryable(:tries => 3) do
        @conn.get('/ratings', params)
      end
    end

    private

    def make_connection
      Faraday.new(ENV['TRUESKILL_URI'])
    end
  end
end
