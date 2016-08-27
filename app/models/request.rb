class Request < ApplicationRecord
  belongs_to :shift
  belongs_to :user
  has_many :request_solutions
  has_many :solutions, through: :request_solutions
  # eagernessは1から4
  validates :eagerness, numericality: {only_integer: true, greater_than: 0, less_than: 5}

  def self.for_select_tag
    all.map do |request|
      [
        request.user.name + " / スコア:" +  request.user.point.to_s + " / 意欲:" + request.eagerness.to_s,
        request.id
      ]
    end
  end

  # userのpoint
  # pointが少ない人が入った時に高くなるように
  def score_by_point
    Math.exp(-user.point)
  end
end
