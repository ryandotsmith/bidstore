Feature: Add a new lane to an existing bid
	In order to gradually build bids 
	As a salesmen 
	I want to add lanes to bids at different times.
	
	Scenario: Adding lanes when the bid is still pending
		Given a bid exists with an id of "12345"
		And I visit the show bid page
		When I follow "add lanes"
		# if i can follow the link to add new lane, then everything should work
		# really need to figure out how to work with JS in cucumber
		And I follow "add new lane"
