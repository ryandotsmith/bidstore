class Bid < ActiveRecord::Base
  belongs_to :customer
  has_many :lanes
  accepts_nested_attributes_for :lanes, :reject_if => proc { |attributes| attributes.all? {|k,v| v["location_string"].blank?} }


  def build_unique_lanes( lanes )
    self.lanes << lanes
  end
  

end
