class Solution < ApplicationRecord
  belongs_to :user
  has_many :requests, through: :request_solutions
end
