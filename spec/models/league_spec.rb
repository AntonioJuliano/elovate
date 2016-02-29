require 'rails_helper'

describe League do
  it 'is valid with presence of a name' do
    l = League.new(name: 'League1')
    expect(l).to be_valid
  end

  it 'is invalid without a name' do
    l = League.new(name: nil)
    l.valid?
    expect(l.errors[:name]).to include("can't be blank")
  end
end
