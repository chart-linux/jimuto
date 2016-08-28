class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :requests
  has_many :solutions
  def accepted_solutions
    Window.all.select{|w| w.confirmed? and w.best_solution.user == @user}
  end
  def achievement_score
    (solutions.count != 0 ? solutions.max{|a, b| a.score <=> b.score }.score : 0) +
    10 * solutions.group_by(&:window).count +
    10 * requests.sum(&:eagerness) +
    20 * requests.count
  end
  def counts_in_window(w)
    in_window(w).count
  end
  def in_window(w)
    requests.where(shift:w.shifts)
  end
end
