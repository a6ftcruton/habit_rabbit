FactoryGirl.define do
  factory :habit do
    association :user
    name "push ups"
    start_date DateTime.now
  end
end
