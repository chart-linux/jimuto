class Solution < ApplicationRecord
  belongs_to :user
  belongs_to :window
  has_many :request_solutions
  has_many :requests, through: :request_solutions
end
