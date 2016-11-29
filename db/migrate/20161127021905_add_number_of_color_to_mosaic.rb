class AddNumberOfColorToMosaic < ActiveRecord::Migration
  def change
    add_column :mosaics, :number_of_colors, :integer
  end
end
