require 'rails_helper'

describe EntriesController do
  let(:entry) { create(:entry) }
  let(:user) { entry.user }

  before do
    @expected_response = {
      'name' => entry.name,
      'elo' => entry.elo,
      'id' => entry.id.to_s,
      'league_id' => entry.league.id.to_s
    }
  end

  context '#create' do
    let(:name) { "salaxgoalie's team" }
    let(:create_params) { { league_id: create(:league).id, name: name } }

    it 'saves entry corresponding to params' do
      starting_entries = Entry.all.length

      post :create, params: { entry: create_params, username: user.username }, format: :json
      
      expect(response.status).to eq(201)
      expect(Entry.all.length).to eq(starting_entries + 1)

      entry = Entry.find(JSON.parse(response.body)['id'])
      expect(entry).to be_present
      expect(entry).to be_valid
      expect(entry.name).to eq(name)
    end

    it 'does not save game on invalid input' do
      starting_entries = Entry.all.length
      create_params[:name] = "waywaytoolongishnameislong"

      post :create, params: { entry: create_params, username: user.username }, format: :json

      expect(Entry.all.length).to eq(starting_entries)
      expect(response.status).to eq(422)
    end
  end

  context '#show' do
    it 'returns correct json' do
      expect(entry).to be_present

      get :show, params: { id: entry.id }, format: :json

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq(@expected_response)
    end
  end

  context '#update' do
    let(:update_params) { { name: 'turtleman755 entry' } }
    let(:invalid_update_params) { { name: 'waywaywaywaywaytoolongusername' } }

    before do
      expect(entry).to be_present
    end

    it 'ensures user is authorized' do
      original_name = entry.name

      post :update, params: { id: entry.id, entry: update_params, username: create(:user).username }, format: :json

      expect(response.status).to eq(401)

      expect(entry.reload.name).to eq(original_name)
    end

    it 'updates the user on valid params' do
      post :update, params: { id: entry.id, username: user.username, entry: update_params }, format: :json

      expect(response.status).to eq(200)

      expect(entry.reload.name).to eq(update_params[:name])
    end

    it 'does not update user on invalid params' do
      post :update, params: { id: entry.id, username: user.username, entry: invalid_update_params }, format: :json

      expect(response.status).to eq(422)
    end
  end

  context '#delete' do
    it 'ensures user is authorized' do
      delete :destroy, params: { id: entry.id, username: create(:user).username }, format: :json

      expect(response.status).to eq(401)

      expect(Entry.where(id: entry.id).first).to be_present
    end

    it 'updates the user on valid params' do
      delete :destroy, params: { id: entry.id, username: user.username }, format: :json

      expect(response.status).to eq(200)

      expect(Entry.where(id: entry.id).first).to_not be_present
    end
  end
end
