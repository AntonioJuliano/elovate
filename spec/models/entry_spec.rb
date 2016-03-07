require 'rails_helper'

describe Entry do
##########################################################################################
## Factorygirl generate
##########################################################################################
  let (:e) {create(:entry)}

##########################################################################################
## Elo validity
##########################################################################################
  it "has a valid elo of type Integer" do
    e.elo.should be_an(Integer)
  end

##########################################################################################
## Association with league cases
##########################################################################################
  it "is valid if it belongs to a league" do
    expect(e).to be_valid
  end

  it "is invalid if it does not belong to a league" do
    e.league = nil
    expect(e.save).to be_falsey
    expect(e.errors[:league]).to include("can't be blank")
  end

##########################################################################################
## Saving to database
##########################################################################################
  describe '#save' do
    it 'updates fields and saves to db' do
      expect { e.save! }.to_not raise_error

      expect(Entry.find(e.id)).to eq(e)
    end
  end

##########################################################################################
end
