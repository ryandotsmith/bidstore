Feature Manage Customers
	In order to better organize bids and lanes 
	As a user
	I want to be able to create, update and delete customers 
	
	Scenario: Adding a new customer 
		Given I am on new customer page 
		And I fill in "customer_name" with "Acme"
		When I press "create"
		Then I should see "added Acme to the database"
		