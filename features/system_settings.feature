Feature: A screen to hold all of the settings for the system
	In order to create custom bids & lanes 
	As a user 
	I want to add default data types to this system 
	
	Scenario: Adding a new trailer type 
		Given I navigate to the settings page 
		When I follow "Edit System Settings"
		Then I should see "Update System Settings"
		When I fill in "trailer_type" with "reefer"
		And I press "update"
		Then I should see "reefer is now a new trailer type"


#	Scenario Adding a new price mode 
	
	