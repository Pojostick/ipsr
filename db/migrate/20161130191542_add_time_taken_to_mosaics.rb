class AddTimeTakenToMosaics < ActiveRecord::Migration
  def change
    add_column :mosaics, :time_taken, :integer
  end
end
