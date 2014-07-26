# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create(first_name: 'Ben', last_name: 'Sterrett', email: 'bs11868@gmail.com', password: "password", password_confirmation: "password")

r = u.reminders.create(title: "Please Remember", text: "Don't forget now", recurring: false, trigger_at: Time.now+300 )

n1 = r.notifications.create(text: "#{r.text}: 5 minute warning", title: r.title, dispatched: 0, trigger_at: r.trigger_at-300 )
n2 = r.notifications.create(text: "#{r.text}: 2 minute warning", title: r.title, dispatched: 0, trigger_at: r.trigger_at-120 )
n3 = r.notifications.create(text: "#{r.text}: Right Now!!", title: r.title, dispatched: 0, trigger_at: r.trigger_at )
