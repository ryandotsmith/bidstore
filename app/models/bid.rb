class Bid < ActiveRecord::Base
  belongs_to :customer
  has_many :lanes
  accepts_nested_attributes_for :lanes
  
end
