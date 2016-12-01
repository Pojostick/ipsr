class AddCompletedToMosaics < ActiveRecord::Migration
  def change
    add_column :mosaics, :completed, :float
  end
end
