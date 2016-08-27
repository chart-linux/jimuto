User.all.each do |user|
  Shift.all.sample(rand(1..20)).each do |shift|
    user.requests.create!(shift: shift)
  end
end
