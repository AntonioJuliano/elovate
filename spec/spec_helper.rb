require 'webmock/rspec'

require 'dotenv'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  Dotenv.load('.env')

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  WebMock.disable_net_connect!(allow_localhost: true)

  config.before(:each) do
    stub_trueskill
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

def stub_trueskill(new_ratings = nil)
  client = TrueSkill::Client.new
  allow(TrueSkill::Service).to receive(:client) { client }
  allow(client).to receive(:get_rating_updates) do |params|
    unless new_ratings
      ratings = []
      params[:teams].each do |t|
        t.each do |rating|
          ratings << {
            id: rating[:id],
            mu: rating[:mu],
            sigma: rating[:sigma]
          } 
        end
      end
    end

    o = OpenStruct.new
    o.body = { new_ratings: (new_ratings || ratings) }.to_json
    o
  end
end