# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
   email: 'test@test.com',
   account_name: 'いけちゃん',
   user_introduction: "よろしくお願いします",
   is_reception: "true",
   profile_image: File.open('./app/assets/images/original_profile.png'),
   complete_request_count: 0,
   password: "000000"
  )

User.create!(
   email: 'test1@test.com',
   account_name: 'くろちゃん',
   user_introduction: "初めまして！",
   is_reception: "true",
   complete_request_count: 0,
   password: "000000"
  )
  
User.create!(
   email: 'test2@test.com',
   account_name: '山中 太陽',
   user_introduction: "見る専門です",
   is_reception: "false",
   complete_request_count: 0,
   password: "000000"
  )
  
User.create!(
   email: 'test3@test.com',
   account_name: '@LeeeN',
   user_introduction: "イラストレーター",
   is_reception: "true",
   profile_image: File.open('./app/assets/images/original_profile_2.jpg'),
   complete_request_count: 0,
   password: "000000"
  )
  
User.create!(
   email: 'test4@test.com',
   account_name: 'ひまわり',
   user_introduction: "見る専門です",
   is_reception: "false",
   complete_request_count: 0,
   password: "000000"
  )
  
PostImage.create!(
  user_id: 1,
  image: File.open('./app/assets/images/illust_1.jpg'),
  title: "イラスト1",
  image_introduction: "好きな漫画"
  )
  
PostImage.create!(
  user_id: 2,
  image: File.open('./app/assets/images/illust_2.png'),
  title: "イラスト2",
  image_introduction: "お気に入り"
  )

PostImage.create!(
  user_id: 1,
  image: File.open('./app/assets/images/illust_3.jpg'),
  title: "イラスト3",
  image_introduction: "名場面"
  )
  
PostImage.create!(
  user_id: 4,
  image: File.open('./app/assets/images/illust_4.jpg'),
  title: "イラスト4",
  image_introduction: "カッコいいシーン"
  )
  
PostImage.create!(
  user_id: 4,
  image: File.open('./app/assets/images/illust_5.png'),
  title: "イラスト5",
  image_introduction: "ハマってます"
  )
  
PostImage.create!(
  user_id: 1,
  image: File.open('./app/assets/images/illust_6.jpg'),
  title: "イラスト6",
  image_introduction: "アベンジャーズ"
  )