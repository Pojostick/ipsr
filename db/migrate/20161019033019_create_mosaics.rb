class CreateMosaics < ActiveRecord::Migration
  def change
    create_table :mosaics do |t|
      t.string   :grid
      t.string   :steps, :array => true, :default => []
      t.timestamps null: false
    end
  end
end
