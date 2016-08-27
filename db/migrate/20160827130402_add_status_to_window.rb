class AddStatusToWindow < ActiveRecord::Migration[5.0]
  def change
    add_column :windows, :status, :integer, null: false, default: 0
  end
end
