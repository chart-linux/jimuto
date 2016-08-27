class UserNameAndPoint < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string, null: false, default: ''
    add_column :users, :point, :integer, null: false, default: 0
  end
end
