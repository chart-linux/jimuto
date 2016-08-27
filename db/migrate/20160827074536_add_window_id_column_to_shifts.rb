class AddWindowIdColumnToShifts < ActiveRecord::Migration[5.0]
  def change
    add_reference :shifts, :window
  end
end
