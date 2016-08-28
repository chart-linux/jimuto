class Window < ApplicationRecord
  has_many :shifts
  has_many :solutions
  enum status: { requesting: 0, solving: 1, confirmed: 2 }

  def period
    first_shift = shifts.order(:start).first
    last_shift = shifts.order(:start).last
    if first_shift.present? && last_shift.present?
      "#{first_shift.start.strftime('%m/%d')} -> #{last_shift.start.strftime('%m/%d')}"
    else
      'Shift is not set yet.'
    end
  end

  def best_solution
    solutions.max{|a, b| a.score <=> b.score}
  end
end
