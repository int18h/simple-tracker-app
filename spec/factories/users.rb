FactoryGirl.define do 
  factory :user do
    sequence(:first_name) { |i| "John #{i}" },
    sequence(:last_name) { |i| "Doe #{i}"},
    sequence(:email) { |i| "john.doe.#{i}@gmail.com" }
  end
end