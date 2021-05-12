# Brain-Controlled-Drone
ESE 498/499 Capstone 2021
Processing Pipeline:
1.	PreprocessingScript
2.	SaveFeats_2_0
3.	Feature Selection and Classification
a.	BinaryClassificationAlgorithm_2_1
b.	MultiClassificationAlgorithm_1_0
4.	Command Signal Construction Functions	
a.	Class2CommandBin
b.	Class2CommandMulti
5.	Helper Functions
a.	getBinaryFeatures
b.	getMultiFeatures

Flight: Running PrimeO will fully initialize the system.  Building the model to the drone from here will initiate a movement right left forward and back for two seconds each starting at 6 seconds.

