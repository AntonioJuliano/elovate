FactoryGirl.define do
  factory :team do
    entries { [create(:entry), create(:entry)] }
  end
end
