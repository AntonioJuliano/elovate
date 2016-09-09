FactoryGirl.define do
  factory :result do
    team 0
    result 0
    entry { create(:entry) }
    game { create(:game) }
  end
end
