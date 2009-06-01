Feature: Add a new lane to an existing bid
	In order to gradually build bids 
	As a salesmen 
	I want to add lanes to bids at different times.
	
	Scenario: Adding lanes when the bid is still pending
		Given a "bid" exists
		And I am on the bid show page
		Then I should see a link to add lanes 
		When I follow the link to add new lanes 
		Then I should see a link to add lanes 
		
		