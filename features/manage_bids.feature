Feature Ability to organize bids 
	In order to better manage bids for customer lanes
	As a Salesman 
	I want to organize my bids
	
	Scenario: Adding a new bid 
		Given a customer exists with an id of "12345"
		And I visit the new bid page 
		And I press "create"
		Then I should see "new bid was created for customer 12345"
		