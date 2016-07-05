Feature:
	As a developer
	In order to track my candies
	I would like to add and view candies

Scenario:
	When I post to create a candy
	Then a candy is created

Scenario:
	Given a candy has been created
	When I get to show a candy
	Then I see the candy details
