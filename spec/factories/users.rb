FactoryGirl.define do 
  factory :user do
    first_name { Faker::Name.name.split(' ').first }
    last_name { Faker::Name.name.split(' ').last }
    email { Faker::Internet.free_email }
    password { Faker::Internet.password(6) }
  end
end