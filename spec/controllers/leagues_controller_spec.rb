require 'rails_helper'

describe LeaguesController do
  let(:league) { create(:league, :with_entry) }
  let(:user) { league.entries.first.user }

  before do
    @expected_response = {
      'id' => league.id.to_s,
      'name' => league.name,
      'description' => league.description,
      'entries' => [{
        'name' => league.entries.first.name,
        'elo' => league.entries.first.elo,
        'id' => league.entries.first.id.to_s,
        'league_id' => league.id.to_s,
      }]
    }
  end

  context '#index' do
    it 'returns correct response' do
      get :index

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq([@expected_response])
    end
  end

  context '#create' do
    let(:name) { 'league-1' }
    let(:entry_name) { 'entry-1' }
    let(:description) { 'descibe' }
    let(:create_params) { { description: description, name: name } }

    it 'saves league corresponding to params' do
      starting_leagues = League.all.length

      post :create, params: { league: create_params, username: user.username, entry_name: entry_name }, format: :json
      
      expect(response.status).to eq(201)
      expect(League.all.length).to eq(starting_leagues + 1)

      league = League.find(JSON.parse(response.body)['id'])
      expect(league).to be_present
      expect(league).to be_valid
      expect(league.name).to eq(name)
      expect(league.description).to eq(description)
      expect(league.entries.length).to eq(1)
      entry = league.entries.first
      expect(entry).to be_valid
      expect(entry.user).to eq(user)
      expect(entry.name).to eq(entry_name)
    end

    it 'does not save game on invalid input' do
      starting_leagues = League.all.length
      starting_entries = Entry.all.length

      post :create, params: { league: create_params, username: user.username }, format: :json

      expect(League.all.length).to eq(starting_leagues)
      expect(Entry.all.length).to eq(starting_entries)
      expect(response.status).to eq(422)
    end
  end

  context '#show' do
    it 'returns correct json' do
      expect(league).to be_present

      get :show, params: { id: league.id }, format: :json

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq(@expected_response)
    end
  end

  context '#update' do
    let(:update_params) { { name: 'newname' } }
    let(:invalid_update_params) { { name: 'waywaywaywaywaytoolongusername' } }

    before do
      expect(league).to be_present
    end

    it 'ensures user is authorized' do
      original_name = league.name

      post :update, params: { id: league.id, league: update_params, username: create(:user).username }, format: :json

      expect(response.status).to eq(401)

      expect(league.reload.name).to eq(original_name)
    end

    it 'updates the user on valid params' do
      post :update, params: { id: league.id, username: user.username, league: update_params }, format: :json

      expect(response.status).to eq(200)

      expect(league.reload.name).to eq(update_params[:name])
    end

    it 'does not update user on invalid params' do
      post :update, params: { id: league.id, username: user.username, league: invalid_update_params }, format: :json

      expect(response.status).to eq(422)
    end
  end

  context '#delete' do
    it 'ensures user is authorized' do
      delete :destroy, params: { id: league.id, username: create(:user).username }, format: :json

      expect(response.status).to eq(401)

      expect(League.where(id: league.id).first).to be_present
    end

    it 'updates the user on valid params' do
      delete :destroy, params: { id: league.id, username: user.username }, format: :json

      expect(response.status).to eq(200)

      expect(League.where(id: league.id).first).to_not be_present
    end
  end
end
