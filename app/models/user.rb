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
end
