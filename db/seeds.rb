# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Activity.delete_all
Request.delete_all
User.delete_all

#seeds users
User.create(email: "admin@gmail.com", password: "password")

users = []
2.times do
  users << User.create!(
  email: Faker::Internet.unique.email,
  password: Faker::Internet.password(min_length: 8)
  )
end

#seeds requests
requests = []
5.times do
  requests << Request.create!(
    user: users.sample,
    duration: rand(1..10),
    lat: Faker::Address.latitude,
    lon: Faker::Address.longitude,
    options: Faker::Lorem.words(number: 3).join(", "),
    category: Faker::Hobby.activity
  )
end

#seeds activities
5.times do
  Activity.create!(
    name: Faker::Lorem.sentence(word_count: 3),
    description: Faker::Lorem.paragraph(sentence_count: 2),
    location: Faker::Address.city,
    request: requests.sample
  )
end

puts "Created #{User.count} users, #{Request.count} requests, and #{Activity.count} activities."
