class Bid < ActiveRecord::Base
  belongs_to :customer
  has_many :lanes
  accepts_nested_attributes_for :lanes, :reject_if => proc { |attributes| attributes.all? {|k,v| v["location_string"].blank?} }

  def build_unique_lanes( lanes )
    lanes.flatten.each do |lane|
      self.lanes << lane if lane.is_unique?(self)
    end
  end

end
