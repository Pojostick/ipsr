class AddTimeSubmittedToMosaics < ActiveRecord::Migration
  def change
    add_column :mosaics, :time_submitted, :integer
  end
end
