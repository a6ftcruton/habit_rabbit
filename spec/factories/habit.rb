FactoryGirl.define do
  factory :habit do
    association :user
    name "push ups"
  end
end
