class AddUserToMosaic < ActiveRecord::Migration
  def change
    add_reference :mosaics, :user, index: true, foreign_key: true
  end
end
