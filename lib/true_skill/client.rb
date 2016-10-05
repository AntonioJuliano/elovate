module TrueSkill
  class Client
    attr_reader :conn

    def initialize
      @conn = make_connection
    end

    def get_rating_updates(params)
      Retryable.retryable(:tries => 3) do
        @conn.post do |req|
          req.url '/ratings'
          req.headers['Content-Type'] = 'application/json'
          req.body = params.to_json
        end
      end
    end

    private

    def make_connection
      Faraday.new(url: ENV['TRUESKILL_URI'])
    end
  end
end
