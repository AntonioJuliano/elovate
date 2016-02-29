require 'rails_helper'

describe Entry do
  before :each do
    League1 = League.new(name: 'League1')
  end
  it "has a valid elo of type Integer" do
    e = Entry.new(elo: 5, league: League1)
    e.elo.should be_an(Integer)
  end

  it "is valid if it belongs to a league" do
    e = Entry.new(elo: 5, league: League1)
    e.valid?
    expect(e).to be_valid
  end

  it "is invalid if it does not belong to a league" do
    e = Entry.new(elo: 5, league: nil)
    e.valid?
    expect(e.errors[:league]).to include("can't be blank")
  end

  describe '#save' do
    it 'updates fields and saves to db' do
    e = Entry.new(elo: 5, league: League1)
      expect { e.save! }.to_not raise_error

      expect(Entry.find(e.id)).to eq(e)
    end
  end
end
