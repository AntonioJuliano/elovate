require 'rails_helper'

describe Game do
  it "has a valid winner" do
    g = Game.new(winner: 'team_one')
    expect(g).to be_valid
  end

  it "does not have a valid winner" do
    g = Game.new(winner: 'something')
    g.valid?
    expect(g.errors[:winner]).to include("Winner is not valid")
  end
end
