class CreateLanes < ActiveRecord::Migration
  def self.up
    create_table :lanes do |t|
      t.belongs_to :bid
      t.integer :status
      t.float :price
      t.float :price_min
      t.string :price_mode
      t.string :special_requirements
      t.string :volume_committed 
      t.string :trailer_type
      t.string :business_relationship
      t.text   :comments
      t.timestamps
    end
  end

  def self.down
    drop_table :lanes
  end
end