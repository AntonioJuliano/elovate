require 'rails_helper'

describe League do
##########################################################################################
## Factorygirl generate
##########################################################################################
  let (:l) {create(:league)}


##########################################################################################
## League name tests
##########################################################################################
  it 'is valid with presence of a name' do
    expect(l).to be_valid
  end

  it 'is invalid without a name' do
    l.name = nil
    expect(l.save).to be_falsey
    expect(l.errors[:name]).to include("can't be blank")
  end
##########################################################################################
end
