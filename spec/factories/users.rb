FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { Faker::Lorem.characters(number: 10) }
    user_name { Faker::Name.unique.name }
    account_name { Faker::Name.unique.name }
    is_reception { "true" }
  end
end

FactoryBot.define do
  factory :test_user, :class => "User" do
    sequence(:email) { |n| "test_user#{n}@example.com" }
    password { Faker::Lorem.characters(number: 10) }
    user_name { Faker::Name.unique.name }
    account_name { Faker::Name.unique.name }
    is_reception { "true" }
  end
end

FactoryBot.define do
  factory :not_reception_user, :class => "User" do
    sequence(:email) { |n| "test_requestinguser#{n}@example.com" }
    password { Faker::Lorem.characters(number: 10) }
    user_name { Faker::Name.unique.name }
    account_name { Faker::Name.unique.name }
    is_reception { "false" }
  end
end
