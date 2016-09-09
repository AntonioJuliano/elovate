require 'rails_helper'

describe Game do
  let (:g) { create(:game) }

  it "has a valid factory" do
    expect(g).to be_valid

    expect(Game.all.length).to eq(1)
  end

  context '#generate' do
    before do
      @league = create(:league)

      num_teams = 2
      entries_per_team = 2

      teams = []
      0.upto(num_teams - 1) do |i|
        teams << { members: [], result: i }
        1.upto(entries_per_team) do
          new_entry = create(:entry, league: @league)

          teams[i][:members] << new_entry.name
        end
      end

      expect(Entry.all.length).to eq(num_teams * entries_per_team)

      test_data = { score: "1 - 1" }

      @params = {
        teams: teams,
        data: test_data
      }
    end

    it 'saves game corresponding to params' do
      expect(Game.all.length).to eq(0)
      expect(Result.all.length).to eq(0)
      game = Game.generate(@league, @params)
      expect(Game.all.length).to eq(1)
      expect(Result.all.length).to eq(4)

      expect(game).to be_valid

      Entry.all.each do |e|
        expect(e.games).to eq([game])
      end
    end

    it 'does not save game on invalid input' do
      @params[:teams][0][:members][0] = 'nonexistent-user'

      expect(Game.all.length).to eq(0)
      expect(Result.all.length).to eq(0)
      game = Game.generate(@league, @params)
      expect(Game.all.length).to eq(0)
      expect(Result.all.length).to eq(0)

      expect(game).to_not be_valid
    end
  end
end
