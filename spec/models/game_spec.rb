require 'rails_helper'

describe Game do
  let (:g) {create(:game)}

  it "has a valid winner" do
    expect(g).to be_valid
  end

end
