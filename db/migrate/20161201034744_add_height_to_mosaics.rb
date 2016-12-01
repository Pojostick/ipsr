class AddHeightToMosaics < ActiveRecord::Migration
  def change
    add_column :mosaics, :height, :integer
  end
end
