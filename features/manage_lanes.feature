Feature: Creating a lane that belongs to a bid 
	In order to get business from customers
	As a user 
	I want to add lanes to a bid. 
	
	Scenario: creating a new lane 
		Given I am on the new lane page 
		And I fill in origin with "64105"
		And I fill in destination with "CA"
		And I fill in "price" with "4.50"
		And I select "CPM" from "lane_price_mode"
		And I fill in "lane_special_requirements" with "53' only" 
		And I select "Reefer" from "lane_trailer_type"
		And I fill in "lane_volume_committed" with "monthly"
		And I fill in "lane_business_relationship" with "brokerage only"
		And I select "proposed" from "lane_status"
		And I press "create"
		Then I should see "success! Lane was created"
		And I should see "Kansas City"
		And I should see "California"
	