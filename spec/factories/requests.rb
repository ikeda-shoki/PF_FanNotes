FactoryBot.define do
  factory :request do
    association :requester, factory: :user
    association :requested, factory: :user
    request_introduction { Faker::Lorem.characters(number: 30) }
    file_format { "jpg" }
    use { Faker::Lorem.characters(number: 30) }
    amount { "1" }
    deadline { "2021/04/20" }
    request_status { "未受付" }
  end
end
