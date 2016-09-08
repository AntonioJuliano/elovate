FactoryGirl.define do
  factory :entry do
    elo 5
    league { create(:league) }
    user { create(:user) }
  end
end
