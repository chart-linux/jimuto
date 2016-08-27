class Solution < ApplicationRecord
  belongs_to :user
  belongs_to :window
  has_many :request_solutions
  has_many :requests, through: :request_solutions

  def score
    # 加味する要素
    # userのpoint
    # そのshiftの人気
    # eagerness

    requests.sum do |request|
      request.score_by_point + request.shift.score_by_popularity + request.eagerness
    end.round(2)
  end
end
