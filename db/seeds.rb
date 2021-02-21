# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create 10 users
prefix=""
10.times do |n|
  prefix=n.to_s.rjust(2, '0')
  name="test"+prefix
  email=name+'@example.com'
  password=name
  User.create!(name: name, email: email, password: password, password_confirmation: password)
end

#create 30 feeds (image is one of 1.jpg～7.jpg)
user_ids=User.ids
(1..30).each do |n|
  random_user_id = user_ids[rand(User.ids.count)]  
  Feed.create!(image: File.open("#{Rails.root.to_s}/public/images_for_seed/#{rand(1..7)}.jpg"), user_id: random_user_id)
end

#create 30 comments 
feed_ids=Feed.ids
(1..30).each do
  random_user_id = user_ids[rand(User.ids.count)]
  random_feed_id = feed_ids[rand(Feed.ids.count)]
  Comment.create!(content: Faker::JapaneseMedia::DragonBall.character,
    user_id: random_user_id,
    feed_id: random_feed_id)
end

#create 30 favorites
(1..30).each do
  random_user_id = user_ids[rand(User.ids.count)]
  random_feed_id = feed_ids[rand(Feed.ids.count)]  
  Favorite.create!(user_id: random_user_id, feed_id: random_feed_id)
end


  
