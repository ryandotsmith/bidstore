Given /^I fill in origin with (.+)$/ do |orig|
  When %{I fill in "lane_origin_location_attributes_location_string" with #{orig}}
end

Given /^I fill in destination with (.+)$/ do |dest|
  When %{I fill in "lane_destination_location_attributes_location_string" with #{dest}}
end

Given /^I visit the new lane page$/ do
  @customer   = Factory( :customer )
  @bid        = Factory( :bid , :customer => @customer )
  visit new_bid_lane_url(@bid)
end

Given /^I visit the show lane page$/ do
  @customer   = Factory( :customer )
  @bid        = Factory( :bid , :customer => @customer )
  @lane       = Factory( :lane, :bid      => @bid )
  visit bid_lane_url(@bid,@lane)
end
