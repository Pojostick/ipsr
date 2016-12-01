class AddTimeTotalToMosaics < ActiveRecord::Migration
  def change
    add_column :mosaics, :time_total, :integer
  end
end
