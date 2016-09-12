FactoryGirl.define do
  factory :league do
    name 'league_test'
    description 'a league for rspec tests'

    trait :with_entry do
      before(:create) do |l|
        create(:entry, league: l, manager: true)
      end
    end
  end
end
