class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.belongs_to :lane
      t.integer :mode
      t.float :lat
      t.float :lng
      t.string :location_string
      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
