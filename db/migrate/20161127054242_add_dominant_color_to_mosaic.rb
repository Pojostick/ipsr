class AddDominantColorToMosaic < ActiveRecord::Migration
  def change
    add_column :mosaics, :dominant_color, :string
  end
end
