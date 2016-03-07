require 'rails_helper'

describe User do
##########################################################################################
## Factory girl generate default case for user
##########################################################################################
  let (:user_default) {create(:user)}


##########################################################################################
## Default case--all should be valid
##########################################################################################
  it 'is valid with a username, first name, and last name' do
    expect(user_default).to be_valid
  end

##########################################################################################
## Username cases
##########################################################################################
  describe 'invalid usernames' do
    it 'without a username' do
      u = User.new(username: nil)
      expect(u.save).to be_falsey
      expect(u.errors[:username]).to include("can't be blank")
    end

    it 'without a valid length of 3-20 characters' do
      u = User.new(username: 'tc')
      expect(u.save).to be_falsey
      expect(u.errors[:username]).to include("is too short (minimum is 3 characters)")

      v = User.new(username: 'asdfghjklasdfghjklasdfghjkl')
      expect(v.save).to be_falsey
      expect(v.errors[:username]).to include("is too long (maximum is 20 characters)")
    end
  end

##########################################################################################
## First name, last name cases
##########################################################################################
  describe 'invalid names' do
    it 'is invalid without a first and last name' do
      u = User.new(first_name: nil, last_name: nil)
      expect(u.save).to be_falsey
      expect(u.errors[:first_name]).to include("can't be blank")
      expect(u.errors[:last_name]).to include("can't be blank")
    end

    it 'is invalid with symbols' do
      u = User.new(first_name: '#cs23fs')
      expect(u.save).to be_falsey
      expect(u.errors[:first_name]).to include("only letters and dashes allowed")
      expect(u.errors[:last_name]).to include("only letters and dashes allowed")
    end
  end

##########################################################################################
## Saving to database
##########################################################################################
  describe '#save' do
    it 'updates fields and saves to db' do
      expect { user_default.save! }.to_not raise_error

      expect(User.find(user_default.id)).to eq(user_default)
    end
  end
##########################################################################################
end
