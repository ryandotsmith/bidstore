class Bid < ActiveRecord::Base
  belongs_to :customer
  has_many :lanes
end
