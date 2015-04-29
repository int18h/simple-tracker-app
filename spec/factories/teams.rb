FactoryGirl.define do 
  factory :team do
    name { Faker::Company.name }  
    association :user_id, factory: :user 
  end
end