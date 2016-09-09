require 'rails_helper'

describe GamesController do
  let(:league) { create(:league) }
  let(:game) { create(:game, league: league) }
  let(:user) { create(:entry, league: league).user }

  before do
    expected_results = []
      game.results.each do |r|
        expected_results << {
          'id' => r.entry.id.to_s,
          'name' => r.entry.name,
          'elo' => r.entry.elo,
          'team' => r.team,
          'result' => r.result
        }
      end

      @expected_response = {
        'id' => game.id.to_s,
        'data' => game.data,
        'league' => {
          'id' => league.id.to_s,
          'name' => league.name
        },
        'results' => expected_results
      }
  end

  context '#index' do
    it 'returns correct json' do
      expect(game).to be_present

      get :index, params: { league_id: league.id }, format: :json

      expect(response.status).to eq(200)

      expect(JSON.parse(response.body)).to eq([@expected_response])
    end
  end

  context '#create' do
    before do
      num_teams = 2
      entries_per_team = 2

      teams = []
      0.upto(num_teams - 1) do |i|
        teams << { members: [], result: i }
        1.upto(entries_per_team) do
          new_entry = create(:entry, league: league)

          teams[i][:members] << new_entry.name
        end
      end

      test_data = { score: "1 - 1" }

      @params = {
        teams: teams,
        data: test_data
      }
    end

    it 'saves game corresponding to params' do
      starting_games = Game.all.length
      starting_results = Result.all.length

      post :create, params: { league_id: league.id, game: @params.to_json, username: user.username }, format: :json
      
      expect(response.status).to eq(200)

      expect(Game.all.length).to eq(starting_games + 1)
      expect(Result.all.length).to eq(starting_results + 4)

      game = Game.find(JSON.parse(response.body)['id'])
      expect(game).to be_present
      expect(game).to be_valid
    end

    it 'does not save game on invalid input' do
      @params[:teams][0][:members][0] = 'nonexistent-user'

      starting_games = Game.all.length
      starting_results = Result.all.length

      post :create, params: { league_id: league.id, game: @params.to_json, username: user.username }, format: :json

      expect(Game.all.length).to eq(starting_games)
      expect(Result.all.length).to eq(starting_results)

      expect(response.status).to eq(422)
    end
  end

  context '#show' do
    it 'returns correct json' do
      expect(game).to be_present

      get :show, params: { league_id: league.id, id: game.id }, format: :json

      expect(response.status).to eq(200)

      expect(JSON.parse(response.body)).to eq(@expected_response)
    end
  end
end
