require 'rails_helper'

describe UsersController do
  let(:user) { create(:user, :with_entry) }

  before do
    @expected_response = {
      'id' => user.id.to_s,
      'username' => user.username,
      'first_name' => user.first_name,
      'last_name' => user.last_name,
      'entries' => [{
        'name' => user.entries.first.name,
        'elo' => user.entries.first.elo,
        'id' => user.entries.first.id.to_s,
        'league_id' => user.entries.first.league.id.to_s,
      }]
    }
  end

  context '#index' do
    it 'returns correct json' do
      expect(user).to be_present

      get :index

      expect(response.status).to eq(200)

      expect(JSON.parse(response.body)).to eq([@expected_response])
    end
  end

  context '#create' do
    let(:create_params) { { username: 'salaxgoalie', first_name: 'Antonio', last_name: 'Juliano' } }

    it 'saves user corresponding to params' do
      starting_users = User.all.length

      post :create, params: { user: create_params }, format: :json
      
      expect(response.status).to eq(201)

      expect(User.all.length).to eq(starting_users + 1)

      user = User.find(JSON.parse(response.body)['id'])
      expect(user).to be_present
      expect(user).to be_valid
      expect(user.username).to eq(create_params[:username])
      expect(user.first_name).to eq(create_params[:first_name])
      expect(user.last_name).to eq(create_params[:last_name])
    end

    it 'does not save game on invalid input' do
      create_params.delete(:username)

      starting_users = User.all.length

      post :create, params: { user: create_params }, format: :json

      expect(User.all.length).to eq(starting_users)

      expect(response.status).to eq(422)
    end
  end

  context '#show' do
    it 'returns correct json' do
      expect(user).to be_present

      get :show, params: { id: user.id }, format: :json

      expect(response.status).to eq(200)

      expect(JSON.parse(response.body)).to eq(@expected_response)
    end
  end

  context '#update' do
    let(:update_params) { { username: 'turtleman755' } }
    let(:invalid_update_params) { { username: 'waywaywaywaywaytoolongusername' } }

    before do
      expect(user).to be_present
    end

    it 'ensures user is authorized' do
      original_username = user.username

      post :update, params: { id: user.id, user: update_params }, format: :json

      expect(response.status).to eq(401)

      expect(user.reload.username).to eq(original_username)
    end

    it 'updates the user on valid params' do
      post :update, params: { id: user.id, username: user.username, user: update_params }, format: :json

      expect(response.status).to eq(200)

      expect(user.reload.username).to eq(update_params[:username])
    end

    it 'does not update user on invalid params' do
      post :update, params: { id: user.id, username: user.username, user: invalid_update_params }, format: :json

      expect(response.status).to eq(422)
    end
  end

  context '#destroy' do
    before do
      expect(user).to be_present
    end

    it 'ensures user is authorized' do
      delete :destroy, params: { id: user.id }, format: :json

      expect(response.status).to eq(401)

      expect(User.where(id: user.id).first).to be_present
    end

    it 'updates the user on valid params' do
      delete :destroy, params: { id: user.id, username: user.username }, format: :json

      expect(response.status).to eq(200)

      expect(User.where(id: user.id).first).to_not be_present
    end
  end
end
