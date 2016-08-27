user = User.find_by(email: 'kumano@kumano-ryo.com')

solution = user.solutions.create!(window: Window.first)

solution.window.shifts.each do |shift|
  solution.request_solutions.create!(request: shift.requests.sample)
end
