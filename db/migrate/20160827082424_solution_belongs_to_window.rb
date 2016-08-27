class SolutionBelongsToWindow < ActiveRecord::Migration[5.0]
  def change
  	add_reference :solutions, :window
  end
end
