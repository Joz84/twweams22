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


u0 =  User.create(email: "admin@gmail.com", password: "azerty", first_name: 'Super', last_name: 'Admin', birthday: '19/08/1998', gender: "male", city: 'Bordeaux', country: 'FRANCE', last_channel_id: c1.id)
u1 =  User.create(email: "a@gmail.com", password: "azerty", first_name: 'Alice', last_name: 'Wonder', birthday: '05/06/1999', gender: "female", city: 'Pessac', country: 'FRANCE', last_channel_id: c1.id)
u2 =  User.create(email: "b@gmail.com", password: "azerty", first_name: 'Boby', last_name: 'Bricoleur', birthday: '23/06/1962', gender: "male", city: 'Liverpool', country: 'ANGLETERRE', last_channel_id: c1.id)
u3 =  User.create(email: "c@gmail.com", password: "azerty", first_name: 'Coco', last_name: 'Castor', birthday: '27/01/1957', gender: "female", city: 'Hanoi', country: 'VIETNAM', last_channel_id: c1.id)


User.all.each do |user|
  Subscription.create(user: user, channel: c1)
end
