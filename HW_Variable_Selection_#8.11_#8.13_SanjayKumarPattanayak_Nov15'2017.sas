/*Problem 8.11*/

ods rtf
file='C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data\HW_VariableSelecction_8.11.rtf';
title "Problem 8.11 Variable Selection";


libname sas_data "C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data" 
access=read;
run;

proc copy in=sas_data out=work;
select lung;
run;

title "Forward Selection of Variables";
proc reg data=lung outest=est;
		model Height_oldest_child = Age_oldest_child Weight_oldest_child Height_mother Weight_mother
Height_father Weight_father / dwProb  VIF  stb ss1 selection=FORWARD ;
OUTPUT OUT=reg_lungOUT predicted=c_predict  RESIDUAL=c_Res
 L95M=c_l95m  U95M=C_u95m  L95=C_l95 U95=C_u95
       rstudent=C_rstudent h=lev cookd=cookd  dffits=dffit
	   STDP=C_spredicted  STDR=C_s_residual STUDENT=C_student     ;
;
		
quit;

title "Backward Selection of Variables";
proc reg data=lung outest=est;
		model Height_oldest_child = Age_oldest_child Weight_oldest_child Height_mother Weight_mother
Height_father Weight_father / dwProb  VIF  stb ss1 selection=BACKWARD ;
OUTPUT OUT=reg_lungOUT predicted=c_predict  RESIDUAL=c_Res
 L95M=c_l95m  U95M=C_u95m  L95=C_l95 U95=C_u95
       rstudent=C_rstudent h=lev cookd=cookd  dffits=dffit
	   STDP=C_spredicted  STDR=C_s_residual STUDENT=C_student     ;
;
		
quit;
title "Stepwise Selection of Variables";
proc reg data=lung;
		model Height_oldest_child = Age_oldest_child Weight_oldest_child Height_mother Weight_mother
		Height_father Weight_father / dwProb  VIF  stb ss1 selection=STEPWISE;
		OUTPUT OUT=reg_lungOUT predicted=c_predict  RESIDUAL=c_Res
 L95M=c_l95m  U95M=C_u95m  L95=C_l95 U95=C_u95
       rstudent=C_rstudent h=lev cookd=cookd  dffits=dffit
	   STDP=C_spredicted  STDR=C_s_residual STUDENT=C_student     ;
;
quit;

title "MAXR Selection of Variables";
proc reg data=lung outest=est;
		model Height_oldest_child = Age_oldest_child Weight_oldest_child Height_mother Weight_mother
Height_father Weight_father / dwProb  VIF  stb ss1 selection=MAXR ;
OUTPUT OUT=reg_lungOUT predicted=c_predict  RESIDUAL=c_Res
 L95M=c_l95m  U95M=C_u95m  L95=C_l95 U95=C_u95
       rstudent=C_rstudent h=lev cookd=cookd  dffits=dffit
	   STDP=C_spredicted  STDR=C_s_residual STUDENT=C_student     ;
;
		
quit;

ods rtf close;


/*Problem 8.13;*/
ods rtf
file='C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data\HW_VariableSelection_8.13.rtf';
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

DATA ParentalHIV2;
set ParentalHIV;
	IF AGEMAR<AGEALC THEN Prior_MAR=1;
	ELSE Prior_MAR=0;
	IF AGESMOKE<AGEALC THEN Prior_Smoke=1;
	ELSE Prior_Smoke=0;
RUN;
proc reg data=ParentalHIV2 outest=est_ParentalHIV2;
	model 
AGEALC = AGE GENDER LIVWITH SIBLINGS	JOBMO	EDUMO	HOWREL	ATTSERV	
NGHB1 - NGHB11	Prior_MAR Prior_Smoke MONFOOD	FINSIT	ETHN	AGESMOKE SMOKEP3M	AGEMAR	FRNDS	SCHOOL	LIKESCH	
HOOKEY	NHOOKEY HMONTH PB01 - PB25 BSI01 - BSI53 
	/ dwProb VIF stb SS1 selection=forward SLENTRY=.20;
	OUTPUT OUT=reg_lungOUT predicted=c_predict  RESIDUAL=c_Res
 L95M=c_l95m  U95M=C_u95m  L95=C_l95 U95=C_u95
       rstudent=C_rstudent h=lev cookd=cookd  dffits=dffit
	   STDP=C_spredicted  STDR=C_s_residual STUDENT=C_student     ;
;
	
quit;



PROC REG DATA=ParentalHIV2;
	MODEL AGEALC= AGE GENDER SIBLINGS EDUMO HOWREL 
					NGHB6 NGHB10 NGHB11 
					Prior_MAR Prior_Smoke SMOKEP3M
					 PB12 PB13 PB18 PB19 PB21 PB22 PB23 
					 BSI10 BSI18 BSI34/ dwProb VIF stb SS1
	SELECTION=MAXR;
	;
	
QUIT;

PROC REG DATA=ParentalHIV2;
	MODEL AGEALC= AGE SIBLINGS EDUMO HOWREL NGHB6 NGHB10 Prior_MAR 
				Prior_Smoke SMOKEP3M PB18 BSI10 BSI18/ NOINT dwProb VIF stb SS1;
	;
	
QUIT;

PROC REG DATA=ParentalHIV2;
	MODEL AGEALC= AGE SIBLINGS EDUMO HOWREL NGHB6 NGHB10 Prior_MAR 
				Prior_Smoke SMOKEP3M BSI10 BSI18/ NOINT  dwProb VIF stb SS1;
	;
	
QUIT;


ods rtf close;
