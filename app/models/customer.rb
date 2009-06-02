class Customer < ActiveRecord::Base
  has_many :bids
  has_many :lanes, :through => :bids
end
