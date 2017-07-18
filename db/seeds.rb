# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Message.destroy_all
Subscription.destroy_all
User.destroy_all
Channel.destroy_all
c1 = Channel.create(name: "general")

u0 =  User.create(email: "doc@gmail.com", password: "azerty", alias: "Doc", last_channel_id: c1.id)
u1 =  User.create(email: "a@gmail.com", password: "azerty", alias: "Alice", last_channel_id: c1.id)
u2 =  User.create(email: "b@gmail.com", password: "azerty", alias: "Bob", last_channel_id: c1.id)
u3 =  User.create(email: "c@gmail.com", password: "azerty", alias: "Charly", last_channel_id: c1.id)
u4 =  User.create(email: "d@gmail.com", password: "azerty", alias: "Dude", last_channel_id: c1.id)

User.all.each do |user|
  Subscription.create(user: user, channel: c1)
end
