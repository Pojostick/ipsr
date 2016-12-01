class RemoveCompletedFromMosaics < ActiveRecord::Migration
  def change
    remove_column :mosaics, :completed, :boolean
  end
end
