/*Problem 12.23 and 12.24;*/
ods pdf
file='C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data\HW_LogisticRegression_12.23_12.24.pdf';
title "LogisticRegression Problem 12.23_12.24";
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
HOOKEY = AGE GENDER LIVWITH SIBLINGS AGESMOKE JOBMO	EDUMO	HOWREL	ATTSERV	NGHB1	NGHB2	NGHB3	NGHB4	NGHB5	NGHB6	NGHB7	NGHB8	NGHB9	NGHB10	NGHB11	MONFOOD	FINSIT	ETHN	AGEALC	AGEMAR	FRNDS	SCHOOL	LIKESCH	NHOOKEY 
	/ dwProb VIF stb SS1 selection=stepwise;
		;
quit;

proc reg data=ParentalHIV2 outest=est_ParentalHIV2;
	model 
NHOOKEY = AGE GENDER LIVWITH SIBLINGS AGESMOKE JOBMO	EDUMO	HOWREL	ATTSERV	NGHB1	NGHB2	NGHB3	NGHB4	NGHB5	NGHB6	NGHB7	NGHB8	NGHB9	NGHB10	NGHB11	MONFOOD	FINSIT	ETHN	AGEALC	AGEMAR	FRNDS	SCHOOL	LIKESCH	HOOKEY 
	/ dwProb VIF stb SS1 selection=stepwise;
		;
quit;

data ParentalHIV2;
	set ParentalHIV;
		if HOOKEY="1." then V_hookey=0;
		else V_hookey=1;
run;


data ParentalHIV2;
	set ParentalHIV;
		if HOOKEY="1." then V_hookey=0;
		else V_hookey=1;
		if GENDER ='1.' then V_gender= 1;
		else V_gender = 0;
		if AGE <17 and AGE >14 then V_age1 =1;
		else V_age1 =0;
		if AGE >=17 then V_age2 =1;
		else V_age2 =0;
		if AGE < 17 then V_age=0;
		else V_age=1;
run;


proc logistic data=ParentalHIV2 descending;
	class  V_gender(ref='0') V_age(ref='0') / param=ref;
	model V_hookey = V_gender V_age  NHOOKEY AGEMAR;
quit;


ods pdf close;
