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
    
    score = requests.sum{|request| 
      request.score_by_point + request.shift.score_by_popularity + request.eagerness/4
    }
    score = (score / requests.count.to_f * 100 )
    user_ids = []
    requests.each do |request|
      user_ids << request.user_id
    end
    # 3回入った人がいれば3というように、一番シフトに入った人の回数を求める。
    duplication_count = user_ids.select{|id| user_ids.count(id) > 1 }.uniq.map{|id| user_ids.count(id)}.max
    score /= duplication_count.to_f
    score.round(2)
  end

  def default_request_id_for_select_tag(shift)
    unless new_record?
      request_solutions.find_by_shift(shift)&.request&.id
    end
  end

  def self.greatest
    all.sort_by { |solution| - solution.score }.first
  end
end
