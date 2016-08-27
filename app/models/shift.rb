class Shift < ApplicationRecord
	has_many :requests
  belongs_to :window

  def score_by_popularity
    # TODO: この分岐をしなくていいように（windowの締め切り機能を作れば良い https://github.com/chart-linux/jimuto/issues/7 ）
    if popularity > 0
      1.to_f / popularity
    else
      0
    end
  end

  def popularity
    requests.count
  end
end
