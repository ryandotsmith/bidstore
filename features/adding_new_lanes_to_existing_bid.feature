Feature: Add a new lane to an existing bid
	In order to gradually build bids 
	As a salesmen 
	I want to add lanes to bids at different times.
	
	Scenario: Adding lanes with a CSV file 
		Given a bid exists with an id of "12345"
		And I visit the show bid page
		When I follow "add lanes"
		Then I should see "Update Bid"
		And I attach the file at "features/import.csv" to "csv_file"
		When I press "import lanes"
		Then I should see "lanes imported"
		