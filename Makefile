test:
	bundle
	cucumber --tags ~@bonus
	
step1:
	bundle 
	cucumber features/step1.feature 
	
step2:
	bundle
	cucumber features/step2.feature 
