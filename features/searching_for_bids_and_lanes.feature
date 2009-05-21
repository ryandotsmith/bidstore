Feature: Searching for lanes or bids based on geographic location 
	In order to quickly find relevant data that will help get new customers
	As a salesman 
	I want to quickly find the most relevant bids or lanes given my search terms
	
	Scenario: I query with zip code parameters 
		When I fill in "search_q" with "bids: 66216 - 64105"
		And I press "search"
		Then I should see "Bids in Kansas City"

	Scenario: I query with City parameters 
		



	Scenario: I query with State parameters 
	



	Scenario: I query with Address parameters 



