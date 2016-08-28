debug_user = User.find_by(email: 'kumano@kumano-ryo.com')
another_user = User.where.not(id: debug_user.id).sample(User.count/2)

[debug_user, another_user].flatten.each do |user|
  solution = user.solutions.create!(window: Window.find(rand(1..Window.count)))

  solution.window.shifts.each do |shift|
    solution.request_solutions.create!(request: shift.requests.sample)
  end
end
