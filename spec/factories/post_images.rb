FactoryBot.define do
  factory :post_image do
    association :user
    image { File.open("#{Rails.root}/app/assets/images/illust_1.jpg") }
    title { Faker::Lorem.characters(number:15) }
    image_introduction { Faker::Lorem.characters(number:20)}
  end
end

FactoryBot.define do
  factory :reception_user_post_image do
    association :reception_user
    image { File.open("#{Rails.root}/app/assets/images/illust_1.jpg") }
    title { Faker::Lorem.characters(number:15) }
    image_introduction { Faker::Lorem.characters(number:20)}
  end
end