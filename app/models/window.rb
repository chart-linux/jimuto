class Window < ApplicationRecord
  has_many :shifts
  enum status: { requesting: 0, solving: 1, confirmed: 2 }
end
