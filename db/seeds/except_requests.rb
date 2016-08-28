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
  user = User.new(
    email: Faker::Internet.email,
    password: Faker::Internet.password(10),
    name: Faker::Name.name,
    point: rand(1..100)
  )
  user.skip_confirmation!
  user.save!
end

# for debug
user = User.new email: 'kumano@kumano-ryo.com', password: 'password', name: '熊野 太郎', admin: true
user.skip_confirmation!
user.save!


time = Date.today.next_week.to_time
5.times do |num|
  window = Window.create(message: %W(A B C D E F G H).sample + "班 当番", status: :requesting)
  7.times do |week_num|
      [[[hour: 8], [hour: 10]], [[hour: 10], [hour: 12, minute: 30]],[ [hour: 12, minute: 30], [hour: 15]],[[hour: 15], [hour: 17, minute: 30]],[[hour: 17, minute: 30],[hour: 20]],[[hour: 20], [hour: 23]]].each do |options|
      Shift.create!(
        start: time.change(options[0][0]),
        end: time.change(options[1][0]),
        window: window
      )
    end
      Shift.create!(
        start: time.change(hour: 23),
        end: time.tomorrow.change(hour: 8),
        window: window
      )
    time = time.tomorrow
  end
end


=begin
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

=end