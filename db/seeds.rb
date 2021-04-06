# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# user
User.create!(
   email: 'test@test.com',
   account_name: 'いけちゃん',
   user_introduction: "よろしくお願いします",
   is_reception: "true",
   profile_image: File.open('./app/assets/images/original_profile.png'),
   complete_request_count: 6,
   password: "000000"
  )

User.create!(
   email: 'test1@test.com',
   account_name: 'くろちゃん',
   user_introduction: "初めまして！ヒロアカ大好きです！ヒロアカ関係のイラスト多めです！爆轟押し",
   is_reception: "true",
   profile_image: File.open('./app/assets/images/illust_7.png'),
   complete_request_count: 3,
   password: "000000"
  )
  
User.create!(
   email: 'test2@test.com',
   account_name: '@LeeeN',
   user_introduction: "写真好き",
   is_reception: "true",
   profile_image: File.open('./app/assets/images/original_profile_2.jpg'),
   complete_request_count: 1,
   password: "000000"
  )
  
User.create!(
   email: 'test3@test.com',
   account_name: '山本 @yuuuta',
   user_introduction: "好きなキャラクターを好きな感じで描きます！依頼どんどん待ってます！",
   is_reception: "true",
   complete_request_count: 0,
   password: "000000"
  )
  
User.create!(
   email: 'test4@test.com',
   account_name: 'ワカサギ100％',
   user_introduction: "依頼して頂ければ精一杯やらせてもらいます！一緒に宣伝してくれたら嬉しいです！",
   is_reception: "true",
   profile_image: File.open('./app/assets/images/original_profile_3.png'),
   complete_request_count: 4,
   password: "000000"
  )
  
User.create!(
   email: 'test5@test.com',
   account_name: '鳥山カマンベールチーズ',
   user_introduction: "ドラゴンボールが大好きです！ドラゴンボール関連の画像多めです。是非フォローしてください！",
   profile_image: File.open('./app/assets/images/illust_4.jpg'),
   is_reception: "true",
   complete_request_count: 2,
   password: "000000"
  )
  
10.times do |n|
  User.create!(
     email: "test#{n + 1}@example.com",
     account_name: Faker::Name.unique.name,
     is_reception: "false",
     password: "000000"
  )
end


#post_image
PostImage.create!(
  user_id: 1,
  image: File.open('./app/assets/images/illust_1.jpg'),
  title: "鬼滅の刃 柱",
  image_introduction: "＃鬼滅の刃 #アニメ #イラスト #柱 #kimetunoyaiba #hasira #お気に入り #ジャンプ",
  post_image_genre: "イラスト"
  )
  
PostImage.create!(
  user_id: 2,
  image: File.open('./app/assets/images/illust_2.png'),
  title: "僕のヒーローアカデミア トガちゃん",
  image_introduction: "＃僕のヒーローアカデミア ＃トガちゃん #アニメ #漫画 #ヒロアカ #ヴィラン #ジャンプ"
  )

PostImage.create!(
  user_id: 1,
  image: File.open('./app/assets/images/illust_3.jpg'),
  title: "甘露寺蜜璃",
  image_introduction: "＃鬼滅の刃　＃甘露寺蜜璃　＃柱　＃恋柱　＃アニメ　＃お気に入りのキャラクター #ジャンプ",
  post_image_genre: "イラスト"
  )
  
PostImage.create!(
  user_id: 6,
  image: File.open('./app/assets/images/illust_4.jpg'),
  title: "ドラゴンボール スーパーゴテンクス",
  image_introduction: "#ドラゴンボール #ゴテンクス #スーパーサイヤ人 #スーパーサイヤ人2 #ドラゴンボールZ #スーパーゴテンクス #イラスト #ジャンプ",
  post_image_genre: "イラスト"
  )
  
PostImage.create!(
  user_id: 1,
  image: File.open('./app/assets/images/illust_5.png'),
  title: "ドラゴンクエスト5 主人公",
  image_introduction: "＃ハマってます #ドラゴンクエスト5 #主人公 #リュカ #ドラゴンクエスト #doragonquest #イラスト",
  post_image_genre: "イラスト"
  )
  
PostImage.create!(
  user_id: 2,
  image: File.open('./app/assets/images/illust_6.jpg'),
  title: "スパイダーマン",
  image_introduction: "#アベンジャーズ #スパイダーマン #蜘蛛 #ヒーロー #disny",
  post_image_genre: "イラスト"
  )

PostImage.create!(
  user_id: 2,
  image: File.open('./app/assets/images/illust_7.png'),
  title: "爆轟",
  image_introduction: "#ヒロアカ #爆轟 #爆発 #イラスト #ジャンプ #アニメ",
  post_image_genre: "イラスト"
  )
  
PostImage.create!(
  user_id: 5,
  image: File.open('./app/assets/images/original_profile_3.png'),
  title: "プロフィール画像",
  image_introduction: "#プロフィール画像 #イラスト #プロフィール",
  post_image_genre: "ロゴ"
  )
  
PostImage.create!(
  user_id: 1,
  image: File.open('./app/assets/images/original_profile.png'),
  title: "アイコン",
  image_introduction: "#プロフィール画像 #イラスト #プロフィール #アイコン画像 #新作",
  post_image_genre: "ロゴ"
  )
  
PostImage.create!(
  user_id: 5,
  image: File.open('./app/assets/images/original_profile_2.jpg'),
  title: "新プロフィール画像",
  image_introduction: "#プロフィール画像 #イラスト #プロフィール #アイコン画像 #新作",
  post_image_genre: "ロゴ"
  )
  
PostImage.create!(
  user_id: 4,
  image: File.open('./app/assets/images/rails.png'),
  title: "Railsロゴ",
  image_introduction: "#ロゴ #rails #プログラミング #アイコン画像 #Ruby",
  post_image_genre: "ロゴ"
  )
  
PostImage.create!(
  user_id: 3,
  image: File.open('./app/assets/images/sunset.jpg'),
  title: "夕日",
  image_introduction: "#写真 #夕日 #sunset #最高！ #たそがれ",
  post_image_genre: "写真"
  )
  
PostImage.create!(
  user_id: 3,
  image: File.open('./app/assets/images/japan2.jpg'),
  title: "神社 鳥居",
  image_introduction: "#写真 #神社 #鳥居 #お願い #好きな写真をあげよう",
  post_image_genre: "写真"
  )
  
PostImage.create!(
  user_id: 3,
  image: File.open('./app/assets/images/airport.jpg'),
  title: "空港 関西国際空港",
  image_introduction: "#写真 #空港 #関空 #昨日の出来事 #旅行",
  post_image_genre: "写真"
  )
  
PostImage.create!(
  user_id: 3,
  image: File.open('./app/assets/images/italy.jpg'),
  title: "大自然",
  image_introduction: "#写真 #自然 #これが最高 #海外旅行 #旅行",
  post_image_genre: "写真"
  )
  
# post_image_comment
3.times do |n|
  PostImageComment.create!(
     user_id: 6 + (n + 1),
     post_image_id: 1,
     comment: Faker::Superhero.name
  )
end

2.times do |n|
  PostImageComment.create!(
     user_id: 7 + (n + 1),
     post_image_id: 2,
     comment: Faker::Superhero.name
  )
end

5.times do |n|
  PostImageComment.create!(
     user_id: 6 + (n + 1),
     post_image_id: 3,
     comment: Faker::Books::Dune.quote
  )
end

8.times do |n|
  PostImageComment.create!(
     user_id: 6 + (n + 1),
     post_image_id: 6,
     comment: Faker::Books::Dune.quote
  )
end

2.times do |n|
  PostImageComment.create!(
     user_id: (n + 1),
     post_image_id: 7,
     comment: Faker::Books::Dune.saying
  )
end

4.times do |n|
  PostImageComment.create!(
     user_id: 3 + (n + 1),
     post_image_id: 8,
     comment: Faker::Books::Dune.saying
  )
end

10.times do |n|
  PostImageComment.create!(
     user_id: 2 + (n + 1),
     post_image_id: 9,
     comment: Faker::Books::Dune.saying
  )
end

4.times do |n|
  PostImageComment.create!(
     user_id: 8 + (n + 1),
     post_image_id: 10,
     comment: Faker::Books::Dune.saying
  )
end

2.times do |n|
  PostImageComment.create!(
     user_id: 10 + (n + 1),
     post_image_id: 11,
     comment: Faker::Books::Dune.saying
  )
end

6.times do |n|
  PostImageComment.create!(
     user_id: 5 + (n + 1),
     post_image_id: 12,
     comment: Faker::Books::Dune.saying
  )
end

7.times do |n|
  PostImageComment.create!(
     user_id: 2 + (n + 1),
     post_image_id: 13,
     comment: Faker::Books::Dune.saying
  )
end

3.times do |n|
  PostImageComment.create!(
     user_id: 9 + (n + 1),
     post_image_id: 14,
     comment: Faker::Books::Dune.saying
  )
end

# favorite

10.times do |n|
  Favorite.create!(
     user_id: 2 + (n + 1),
     post_image_id: 1,
  )
end

5.times do |n|
  Favorite.create!(
     user_id: (n + 1),
     post_image_id: 2,
  )
end

8.times do |n|
  Favorite.create!(
     user_id: 4 + (n + 1),
     post_image_id: 3,
  )
end

6.times do |n|
  Favorite.create!(
     user_id: 6 + (n + 1),
     post_image_id: 4,
  )
end

1.times do |n|
  Favorite.create!(
     user_id: 10,
     post_image_id: 5,
  )
end

4.times do |n|
  Favorite.create!(
     user_id: 1 + (n + 1),
     post_image_id: 8,
  )
end

9.times do |n|
  Favorite.create!(
     user_id: (n + 1),
     post_image_id: 9,
  )
end

2.times do |n|
  Favorite.create!(
     user_id: 9 + (n + 1),
     post_image_id: 10,
  )
end

8.times do |n|
  Favorite.create!(
     user_id: 7 + (n + 1),
     post_image_id: 11,
  )
end

5.times do |n|
  Favorite.create!(
     user_id: 1 + (n + 1),
     post_image_id: 12,
  )
end

8.times do |n|
  Favorite.create!(
     user_id: 2 + (n + 1),
     post_image_id: 13,
  )
end

6.times do |n|
  Favorite.create!(
     user_id: 4 + (n + 1),
     post_image_id: 14,
  )
end

1.times do |n|
  Favorite.create!(
     user_id: 3 + (n + 1),
     post_image_id: 15,
  )
end

# request

Request.create!(
  requester_id: 8,
  requested_id: 1,
  request_introduction: "インスタグラムのアイコンの依頼",
  file_format: 1,
  deadline: "2021/4/30",
  use: "インスタのアイコンで使用"
  )

Request.create!(
  requester_id: 9,
  requested_id: 3,
  request_introduction: "HPのオリジナルキャラクターを製作して欲しい",
  file_format: 1,
  amount: 4,
  deadline: "2021/5/20",
  use: "HPのオリジナルキャラクターとして使用したいです。男のキャラクターを3体、女のキャラクターを1体製作してくれませんか？"
  )

Request.create!(
  requester_id: 1,
  requested_id: 6,
  request_introduction: "似顔絵を描いて欲しい",
  file_format: 0,
  amount: 1,
  deadline: "2021/5/10",
  use: "記念日に彼女との似顔絵をプレゼントしたくて、お願いしたいです！"
  )