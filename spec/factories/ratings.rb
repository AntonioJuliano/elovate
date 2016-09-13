FactoryGirl.define do
  factory :rating do
    entry { create(:entry) }
    mu 1000.0
    sigma 332.0
  end
end
