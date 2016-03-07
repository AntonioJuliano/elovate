FactoryGirl.define do
  factory :entry do
    elo 5
    league {create(:league)}
  end
end
