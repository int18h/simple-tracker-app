# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = [
  ['Dmitriy', 'Goncharov', 'd.goncharov@mobidev.biz', '$2a$10$K1uY0cGLU62feyrjzGo5D..UuSvqx9ka1CjaQenQjtb7qZsrN9ZE6'],
  ['Nastya', 'Shykhailo', 'n.shykhailo@mobidev.biz', '$2a$10$K1uY0cGLU62feyrjzGo5D..UuSvqx9ka1CjaQenQjtb7qZsrN9ZE6'],
  ['Sergei', 'Koba', 's.koba@mobidev.biz', '$2a$10$K1uY0cGLU62feyrjzGo5D..UuSvqx9ka1CjaQenQjtb7qZsrN9ZE6']
]

users.each do |first_name, last_name, email, password_digest|
  puts first_name
  User.create(first_name: first_name, last_name: last_name, email: email, password_digest: password_digest)
end
