class CreateBids < ActiveRecord::Migration
  def self.up
    create_table :bids do |t|
      t.belongs_to :customer
      t.text :comments
      t.timestamps
    end
  end

  def self.down
    drop_table :bids
  end
end
