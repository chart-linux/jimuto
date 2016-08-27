class AddUserIdColumnToRequests < ActiveRecord::Migration[5.0]
  def change
    add_reference :requests, :user
  end
end
