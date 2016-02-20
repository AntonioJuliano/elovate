require 'rails_helper'

describe User do
  context '#save' do
    it 'updates fields and saves to db' do
      u = User.new
      username = "user1"
      u.username = username

      expect { u.save! }.to_not raise_error

      expect(User.find(u.id)).to eq(u)
    end
  end

  context 'user factory' do
    it 'creates a valid user' do
      create(:user)
    end
  end
end
