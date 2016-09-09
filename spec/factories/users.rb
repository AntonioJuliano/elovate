FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user-#{n}" }
    first_name 'Bob'
    last_name 'Smith'
  end
end
