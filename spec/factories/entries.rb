FactoryGirl.define do
  factory :entry do
    sequence(:name) { |n| "entry-#{n}" }
    league { create(:league) }
    user { create(:user) }

    before(:create) do |entry|
      create(:rating, entry: entry)
    end
  end
end

