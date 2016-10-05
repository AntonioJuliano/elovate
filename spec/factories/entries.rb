FactoryGirl.define do
  factory :entry do
    sequence(:name) { |n| "entry-#{n}" }
    league { create(:league) }
    user { create(:user) }
  end
end

