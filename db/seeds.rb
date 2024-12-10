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
Request.destroy_all
User.destroy_all

admin = User.create!(email: "admin@gmail.com", password: "password")
testreq = Request.new(duration: 60, lat: 43.298569, lon: 5.372766)
testreq.user = admin
testreq.save!

#seeds users

users = []
2.times do
  users << User.create!(
  email: Faker::Internet.unique.email,
  password: Faker::Internet.password(min_length: 8)
  )
end

#seeds requests
requests = []
users.each do |user|
  3.times do
    lat = Faker::Address.latitude
    lon = Faker::Address.longitude
    requests << Request.create!(
      user: user,
      duration: rand(5..240),
      lat: lat,
      lon: lon,
      options: Faker::Lorem.words(number: 3).join(", "),
      category: Faker::Hobby.activity
    )
  end
end

#seeds activities
requests.each do |request|
  5.times do
    Activity.create!(
      name: Faker::Lorem.sentence(word_count: 3),
      description: Faker::Lorem.paragraph(sentence_count: 2),
      location: Faker::Address.city,
      request: request
    )
  end
end

puts "Created #{User.count} users, #{Request.count} requests, and #{Activity.count} activities."