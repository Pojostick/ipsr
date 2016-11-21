class AddGridsToMosaics < ActiveRecord::Migration
  def change
    add_column :mosaics, :grids, :string
  end
end
