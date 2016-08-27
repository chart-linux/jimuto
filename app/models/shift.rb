class Shift < ApplicationRecord
	has_many :requests
  belongs_to :window
end
