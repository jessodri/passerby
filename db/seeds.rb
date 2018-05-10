# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 11.times do |n|
# email = "example-#{n+1}@example.org"
# password = "password"
# User.create!(
#       email: email,
#       password:              password,
#       password_confirmation: password
#       )
# end

# users = User.order(created_at: :desc).take(11)
# addresses = [
#     {
#         address_line_one: "313 Spencer St", 
#         city: "Docklands", 
#         postcode: "3008",
#         },
#         {
#         address_line_one: "582 Little Collins St", 
#         city: "Melbourne", 
#         postcode: "3000",
#         },
#         {
#         address_line_one: "535 Bourke St",
#         city: "Melbourne", 
#         postcode: "3000",
#         },
#         {
#         address_line_one: "171 King St",
#         city: "Melbourne", 
#         postcode: "3000",
#         },
#         {
#         address_line_one: "350 Bourke St",
#         city: "Melbourne", 
#         postcode: "3000",
#         },
#         {
#         address_line_one: "99 Spencer St",
#         city: "Docklands", 
#         postcode: "3008",
#         },
#         {
#         address_line_one: "201 Victoria Parade",
#         city: "Collingwood", 
#         postcode: "3066",
#         },
#         {
#         address_line_one: "15 McKillop St",
#         city: "Melbourne", 
#         postcode: "3000",
#         },
#         {
#         address_line_one: "517 Flinders Ln", 
#         city: "Melbourne", 
#         postcode: "3000",
#         },
#         {
#         address_line_one: "44 Spencer St",
#         city: "Melbourne",
#         postcode: "3000",
#         },
#         {
#         address_line_one: "492 Little Collins St", 
#         city: "Melbourne", 
#         postcode: "3000",
#         }]
# users.each_with_index do |user, index|
#   address = addresses[index]
#   user.build_profile(first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     state: "VIC",
#     country_code: "AU",
#     address_line_one: address[:address_line_one],
#     city: address[:city],
#     postcode: address[:post_code])
#     user.save
# end
