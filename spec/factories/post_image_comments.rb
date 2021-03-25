FactoryBot.define do
  factory :post_image_comment do
    association :post_image
    user { post_image.user }
    comment { Faker::Lorem.characters(number:15) }
  end
end