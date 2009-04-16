class Customer < ActiveRecord::Base
  has_many :bids
end
