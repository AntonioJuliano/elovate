require 'rails_helper'

describe Entry do
  let (:e) { create(:entry) }

  it "has a valid factory" do
    expect(e).to be_valid
  end

  it "is invalid if it does not belong to a league" do
    e.league = nil
    expect(e.save).to be_falsey
    expect(e.errors[:league]).to include("can't be blank")
  end

  describe '#save' do
    it 'updates fields and saves to db' do
      expect { e.save! }.to_not raise_error

      expect(Entry.find(e.id)).to eq(e)
    end
  end
end
