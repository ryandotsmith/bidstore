Given /^I fill in origin with (.+)$/ do |orig|
  When %{I fill in "lane_origin_location_attributes_location_string" with #{orig}}
end

Given /^I fill in destination with (.+)$/ do |dest|
  When %{I fill in "lane_destination_location_attributes_location_string" with #{dest}}
end
