class CreateLanes < ActiveRecord::Migration
  def self.up
    create_table :lanes do |t|
      t.belongs_to :bid
      t.integer :status, :default => 0
      t.float :price
      t.float :price_min
      t.string :price_mode
      t.string :special_requirements
      t.string :volume
      t.string :trailer_type
      t.string :business_relationship
      t.string :miles
      t.text   :comments
      t.timestamps
    end
  end

  def self.down
    drop_table :lanes
  end
end