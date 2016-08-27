class AddReferencesToRequestSolution < ActiveRecord::Migration[5.0]
  def change
  	add_reference :request_solutions, :request
  	add_reference :request_solutions, :solution
  	add_reference :solutions, :user
  end
end
