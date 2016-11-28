class AddCompletedToMosaic < ActiveRecord::Migration
  def change
    add_column :mosaics, :completed, :boolean
  end
end
