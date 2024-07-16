Pre_Requisite: Install s(CASP)- https://gitlab.software.imdea.org/ciao-lang/sCASP


a) <dataset_name>Folders Contain 2 files each: 
	1) <dataset_name>_FOLD-SE.pl: code using FOLD-SE Rules
	2) <dataset_name>_RIPPER.pl: code using FOLD-SE Rules

b) Ensure that you are inside the folder containing the <dataset_name>_FOLD-SE.pl/<dataset_name>_RIPPER.pl file.

b) To run on s(CASP) , launch s(CASP) on the terminal and run the following query (example used is the titanic dataset):
	1) scasp titanic_FOLD-SE.pl --prev_forall -s0

	2) scasp titanic_RIPPER.pl --prev_forall -s0
