class RemoveGridsFromMosaics < ActiveRecord::Migration
  def change
    remove_column :mosaics, :grids, :string
  end
end
