require 'rails_helper'

describe User do
  it 'is valid with a username, first name, and last name' do
    u = User.new(
      username: 'bob_smith',
      first_name: 'Bob',
      last_name: 'Smith')
    expect(u).to be_valid
  end

  describe 'invalid usernames' do
    it 'without a username' do
      u = User.new(username: nil)
      u.valid?
      expect(u.errors[:username]).to include("can't be blank")
    end

    it 'without a valid length of 3-20 characters' do
      u = User.new(username: 'tc')
      u.valid?
      expect(u.errors[:username]).to include("is too short (minimum is 3 characters)")

      v = User.new(username: 'asdfghjklasdfghjklasdfghjkl')
      v.valid?
      expect(v.errors[:username]).to include("is too long (maximum is 20 characters)")
    end
  end

  describe 'invalid names' do
    it 'is invalid without a first and last name' do
      u = User.new(first_name: nil, last_name: nil)
      u.valid?
      expect(u.errors[:first_name]).to include("can't be blank")
      expect(u.errors[:last_name]).to include("can't be blank")
    end

    it 'is invalid with symbols' do
      u = User.new(first_name: '#cs23fs')
      u.valid?
      expect(u.errors[:first_name]).to include("only letters and dashes allowed")
      expect(u.errors[:last_name]).to include("only letters and dashes allowed")
    end
  end

  describe '#save' do
    it 'updates fields and saves to db' do
    u = User.new(
      username: 'bob_smith',
      first_name: 'Bob',
      last_name: 'Smith')
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
