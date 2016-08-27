class Request < ApplicationRecord
  belongs_to :shift
  belongs_to :user
  has_many :request_solutions
  has_many :solutions, through: :request_solutions
end
