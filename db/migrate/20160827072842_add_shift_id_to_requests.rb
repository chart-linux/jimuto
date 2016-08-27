class AddShiftIdToRequests < ActiveRecord::Migration[5.0]
  def change
    add_reference :requests, :shift
  end
end
