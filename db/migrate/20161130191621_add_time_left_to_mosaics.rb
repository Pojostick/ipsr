class AddTimeLeftToMosaics < ActiveRecord::Migration
  def change
    add_column :mosaics, :time_left, :integer
  end
end
