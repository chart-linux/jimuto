class RequestSolution < ApplicationRecord
  belongs_to :request
  belongs_to :solution

  scope :find_by_shift, -> (shift) { joins(request: :shift).find_by(id: shift.id) }
end
