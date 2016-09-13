require 'rails_helper'

describe TrueSkill::Service do
  let(:game) { create(:game) }
  let(:first_rating) { game.results.first.entry.rating }
  let(:last_rating) { game.results.last.entry.rating }
  let(:first_mu) { 100.0 }
  let(:first_sigma) { 3.0 }
  let(:last_mu) { 500.0 }
  let(:last_sigma) { 2.0 }
  let(:new_ratings) do 
    [{ id: first_rating.id.to_s, mu: first_mu, sigma: first_sigma },
     { id: last_rating.id.to_s, mu: last_mu, sigma: last_sigma }]
  end

  context '#update_ratings_for_game' do
    before do
      stub_trueskill(new_ratings)
    end

    it 'updates rating fields as per trueskill response' do
      expect(TrueSkill::Service.update_ratings_for_game(game)).to be_truthy
      
      expect(first_rating.mu).to eq(first_mu)
      expect(first_rating.sigma).to eq(first_sigma)
      expect(last_rating.mu).to eq(last_mu)
      expect(last_rating.sigma).to eq(last_sigma)
    end
  end
end
