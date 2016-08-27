class AddColumnsToRequest < ActiveRecord::Migration[5.0]
  def change
  	add_column :requests, :eagerness, :int, null: false, default: 0
  end
end
