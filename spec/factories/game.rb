FactoryGirl.define do
  factory :game do
    winner { create(:team) }
    loser { create(:team) }
  end
end
