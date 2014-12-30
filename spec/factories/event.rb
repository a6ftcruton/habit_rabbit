FactoryGirl.define do
  factory :event do
    association :habit
    completed true 
    created_at "2014-12-1 22:40:48" 
  end
end
