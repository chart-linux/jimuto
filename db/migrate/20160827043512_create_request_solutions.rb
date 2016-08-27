class CreateRequestSolutions < ActiveRecord::Migration[5.0]
  def change
    create_table :request_solutions do |t|

      t.timestamps
    end
  end
end
