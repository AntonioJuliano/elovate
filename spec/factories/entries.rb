FactoryGirl.define do
  factory :entry do
    elo 5
    sequence(:name) { |n| "entry-#{n}" }
    league { create(:league) }
    user { create(:user) }
  end
end
