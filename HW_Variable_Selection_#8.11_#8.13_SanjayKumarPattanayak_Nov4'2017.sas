/*Problem 8.11*/

ods pdf
file='C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data\HW_VariableSelecction_8.11.pdf';
title "Problem 8.11 Variable Selection";


libname sas_data "C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data" 
access=read;
run;

proc copy in=sas_data out=work;
select lung;
run;



proc reg data=lung outest=est_lung;
	model 
Height_oldest_child = Age_oldest_child Weight_oldest_child Height_mother Weight_mother Height_father Weight_father 
	/ dwProb VIF stb SS1 selection=forward;
		;
quit;

ods pdf close;


/*Problem 8.13;*/
ods pdf
file='C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data\HW_VariableSelection_8.13.pdf';
title "Variable Selection Problem 8.13";
PROC IMPORT OUT= WORK.ParentalHIV 
            DATAFILE= "C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\S
AS_KashaDehnad\SAS_data\ParentalHIV.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

data ParentalHIV2;
	set ParentalHIV;
run;

proc reg data=ParentalHIV2 outest=est_ParentalHIV2;
	model 
AGESMOKE = AGE GENDER LIVWITH SIBLINGS	JOBMO	EDUMO	HOWREL	ATTSERV	NGHB1	NGHB2	NGHB3	NGHB4	NGHB5	NGHB6	NGHB7	NGHB8	NGHB9	NGHB10	NGHB11	MONFOOD	FINSIT	ETHN	AGEALC	AGEMAR	FRNDS	SCHOOL	LIKESCH	HOOKEY	NHOOKEY 
	/ dwProb VIF stb SS1 selection=forward;
		;
quit;


ods pdf close;
