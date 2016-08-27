# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

Faker::Config.locale = :ja

# generate user
40.times do
  user = User.new email: Faker::Internet.email, password: Faker::Internet.password(10), name: Faker::Name.name
  user.skip_confirmation!
  user.save!
end

# for debug
user = User.new email: 'kumano@kumano-ryo.com', password: 'password', name: '熊野 太郎'
user.skip_confirmation!
user.save!

window = Window.create! message: Faker::Hacker.say_something_smart

# generate shift
(Date.today.beginning_of_week..Date.today.end_of_week).each do |date|
  [8, 11, 14, 17, 20].each do |start_hour|
    Shift.create!(
      start: date.to_time.change(hour: start_hour),
      end: date.to_time.change(hour: start_hour + 3),
      window: window
    )
  end
  Shift.create!(
    start: date.to_time.change(hour: 23),
    end: date.next_day.to_time.change(hour: 8),
    window: window
  )
end
