Feature:
	As a developer
	In order to maximize existing software
	I would like to receive 

@bonus
Scenario:
	Given a candy doesn't exist
	When a developer requests a candy that doesn't exist
	Then a 404 is returned

@bonus
Scenario:
	When a developer does not include a color when making a candy
	Then a 422 is returned
