FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user-#{n}" }
    first_name 'Bob'
    last_name 'Smith'

    trait :with_entry do
      before(:create) do |u|
        create(:entry, user: u)
      end
    end
  end
end
