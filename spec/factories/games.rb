FactoryGirl.define do
  factory :game do
    league { create(:league) }

    before(:create) do |game|
      create(:result, game: game, team: 0, result: 0)
      create(:result, game: game, team: 1, result: 1)
    end
  end
end
