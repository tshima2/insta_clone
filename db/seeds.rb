# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

prefix=""
10.times do |n|
  prefix=n.to_s.rjust(2, '0')
  name="test"+prefix
  email=name+'@example.com'
  password=name
  User.create!(name: name, email: email, password: password, password_confirmation: password)
end


#(1..10).each do
#  Comment.create!(content: Faker::JapaneseMedia::DragonBall.character, user_id: rand(10))
#end


  
