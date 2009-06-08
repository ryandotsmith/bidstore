Feature Ability to organize bids 
	In order to better manage bids for customer lanes
	As a Salesman 
	I want to organize my bids
	
	Scenario: Adding a new bid 
		Given a customer exists with an id of "12345"
		And I visit the show customer page 
		And I follow "add bids"
		And I fill in "comments" with "we will win fo sho"
		And I press "add bid"
		Then I should see "new bid was created"
		