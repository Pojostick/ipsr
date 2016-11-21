class AddStepCounterToMosaics < ActiveRecord::Migration
  def change
    add_column :mosaics, :step_counter, :integer
  end
end
