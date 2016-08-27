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

  def default_request_id_for_select_tag
    unless new_record?
      request_solutions.find_by_shift(shift)&.request&.id
    end
  end

  def self.greatest
    all.sort_by { |solution| - solution.score }.first
  end
end
