test:
	bundle
	cucumber --tags ~@bonus
	
step1:
	bundle 
	cucumber features/step1.feature 
	
step2:
	bundle
	cucumber features/step2.feature 

step3:
	bundle
	cucumber features/step3.feature 

step4:
	bundle
	cucumber features/step4.feature 
