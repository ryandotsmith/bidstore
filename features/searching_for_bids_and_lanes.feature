Feature: Searching for lanes or bids based on geographic location 
	In order to quickly find relevant data that will help get new customers
	As a salesman 
	I want to quickly find the most relevant bids or lanes given my search terms
	
	Scenario: I query bids with zip code parameters and then remove destination 
		Given I am on the customers index page
		When I fill in "search_q" with "bids: 66216 - 64105"
		And I press "search"
		Then I should see "bids" with destination "64105"
		And I should see "bids" with origin "66216"
		When I check "destination" # indicating removal of parameter 
		And I press "update search"
		Then I should see "bids" with destination "california" # not 64105


	Scenario: I query with City parameters and then remove the origin and add a destination
		Given I visit the show lane page
		When I fill in "search_q" with "66216"
		And I press "search"
		Then I should see "bids and lanes" with destination "66216"
		Then I should see "bids and lanes" with origin "66216"
		When I check "origin"
		And I fill in "destination" with "california"
		When I press "update search"
		Then I should see "bids and lanes" with destination "california"
		
		
	Scenario: I query with Address parameters 
		Given I visit the show bid page
		When I fill in "search_q" with "2540 S. 88th St. Kansas City KS"
		And I press "search"
		Then I should see "bids and lanes" with destination "2540 S. 88th St. Kansas City KS"
		Then I should see "bids and lanes" with origin "2540 S. 88th St. Kansas City KS"
		When I check "only bids"
		And I press "update search"
		Then I should see "bids" with destination "2540 S. 88th St. Kansas City KS"
		And I should see "bids" with origin "2540 S. 88th St. Kansas City KS"
	