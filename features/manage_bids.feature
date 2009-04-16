Feature Ability to organize bids 
	In order to better manage bids for customer lanes
	As a Salesman 
	I want to organize my bids
	
	Scenario: Adding a new bid 
		Given I am on the new bid page 
		And a customer exists with an id of "12345"
		When I fill in "bid_customer_id" with "123445"
		And I press "create"
		Then I should see "new bid was created"
		