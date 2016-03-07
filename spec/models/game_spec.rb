require 'rails_helper'

describe Game do
##########################################################################################
## Factorygirl generate
##########################################################################################
  let (:g) {create(:game)}

##########################################################################################
## Winner type cases
##########################################################################################
  it "has a valid winner" do
    expect(g).to be_valid
  end

  it "does not have a valid winner" do
    g.winner = 'something'
    g.valid?
    expect(g.errors[:winner]).to include("Winner is not valid")
  end
##########################################################################################

end
