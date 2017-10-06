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
c1 = Channel.create(name: 'general')

u0 =  User.create(email: 'a@gmail.com', password: 'azerty', first_name: 'Super', last_name: 'Admin', birthday: Date.today, gender: 'male', city: 'Bordeaux', country: 'FRANCE', last_channel_id: Channel.first)
u0 =  User.create(email: 'm@gmail.com', password: 'azerty', first_name: 'Mega', last_name: 'Admin', birthday: Date.today, gender: 'male', city: 'Lyon', country: 'FRANCE', last_channel_id: Channel.first)
u0 =  User.create(email: 'g@gmail.com', password: 'azerty', first_name: 'Genial', last_name: 'Admin', birthday: Date.today, gender: 'male', city: 'La Rochelle', country: 'FRANCE', last_channel_id: Channel.first)
u0 =  User.create(email: 'e@gmail.com', password: 'azerty', first_name: 'Extra', last_name: 'Admin', birthday: Date.today, gender: 'male', city: 'Toulouse', country: 'FRANCE', last_channel_id: Channel.first)

User.all.each do |user|
  Subscription.create(user: user, channel: c1)
end
