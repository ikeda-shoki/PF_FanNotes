FactoryBot.define do
  factory :request_image do
    association :request
    complete_image { File.open("#{Rails.root}/app/assets/images/illust_1.jpg") }
  end
end
