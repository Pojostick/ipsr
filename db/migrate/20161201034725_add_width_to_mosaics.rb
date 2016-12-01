class AddWidthToMosaics < ActiveRecord::Migration
  def change
    add_column :mosaics, :width, :integer
  end
end
