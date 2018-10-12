proc copy in=sashelp out=work;
select iris;
run;

title "Pricipal Component Analysis";
title2 "Univariate Analysis"

proc univariate data=iris;
	var SepalLength PetalWidth PetalLength;
run;

title "Multiple Regression for SepalLength on PetalLength Petal Width";

proc reg data=iris;
model SepalLength= PetalWidth PetalLength / ;
;
quit;

proc reg data=iris;
model SepalLength= PetalWidth / ;
;
quit;

proc reg data=iris;
model SepalLength= PetalLength / ;
;
quit;


proc reg data=iris;
model SepalLength= PetalWidth PetalLength / VIF;
;
quit;


*import cerals;
libname sas_data "C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data";
run;
proc copy in=sas_data out=work;
select cereal_ds;
run;

title "Multiple Regression for the cereal dataset rating vs sugars and fiber";
proc reg data=cereal_ds;
	model rating = sugars fiber /VIF;
quit;

proc standard data=cereal_ds mean=0 std=1
out=cereal_ds_z;
VAR rating sugars fiber;
run;

proc reg data=cereal_ds_z;
	model rating = sugars fiber /VIF;
quit;


proc reg data=cereal_ds;
	model rating = sugars fiber /VIF stb;
quit;



proc reg data=cereal_ds;
	model rating = sugars / stb;
	OUTPUT OUT=reg_cerealOUT PREDICTED=c_predict
	RESIDUAL=c_Res
	rstudent=C_rstudent h=lev cookd=Cookd dffits=dffit
	;
quit;


proc reg data=cereal_ds;
	model rating = fiber / ;
	
	;
quit;
proc reg data=cereal_ds;
	model rating = fiber / stb;
	OUTPUT OUT=reg_cerealOUT PREDICTED=c_predict
	RESIDUAL=c_Res
	rstudent=C_rstudent h=lev cookd=Cookd dffits=dffit
	;
quit;

proc reg data=cereal_ds;
	model rating = fiber sugars / ;
	
	;
quit;


proc reg data=reg_cerealOUT ;
model c_Res= fiber / ;
;
quit;



proc reg data=cereal_ds;
	model rating = sugars fiber / VIF stb SS1;
	OUTPUT OUT=reg_cerealOUT PREDICTED=c_predict
	RESIDUAL=c_Res
	rstudent=C_rstudent h=lev cookd=Cookd dffits=dffit
	;
quit;

proc reg data=cereal_ds outest=est_cereal;
	model 
rating = sugars fiber sodium fat protein carbo calories vitamins 
	/ dwProb VIF stb SS1;
		;
quit;

proc reg data=cereal_ds outest=est_cereal;
	model 
rating = sugars fiber shelf sodium fat protein carbo calories vitamins 
	/ dwProb VIF stb SS1;
		;
quit;

data cereal_ds2;
set cereal_ds;
if shelf=1 then shelf1=1;
else shelf1=0;
if shelf=2 then shelf2=1;
else shelf2=0;
if shelf=3 then shelf3=1;
else shelf3=0;
run;


proc reg data=cereal_ds2 outest=est_cereal;
	model 
rating = sugars fiber shelf2 shelf3 sodium fat protein carbo calories vitamins 
	/ dwProb VIF stb SS1;
		;
quit;

proc reg data=cereal_ds2 outest=est_cereal;
	model 
rating = shelf2 shelf3
	/ dwProb VIF stb SS1;
		;
quit;

proc reg data=cereal_ds2 outest=est_cereal;
	model 
rating = sugars fiber shelf2 shelf3 sodium fat protein carbo calories vitamins 
	/ dwProb VIF stb SS1 selection=forward;
		;
quit;

proc reg data=cereal_ds2 outest=est_cereal;
	model 
rating = sugars fiber shelf2 shelf3 sodium fat protein carbo calories vitamins 
	/ dwProb VIF stb SS1 selection=backward;
		;
quit;

proc reg data=cereal_ds2 outest=est_cereal;
	model 
rating = sugars fiber shelf2 shelf3 sodium fat protein carbo calories vitamins 
	/ dwProb VIF stb SS1 selection=stepwise;
		;
quit;


proc reg data=cereal_ds2 outest=est_cereal;
	model 
rating = sugars fiber shelf2 shelf3 sodium fat protein carbo calories vitamins 
	/ dwProb VIF stb SS1 selection=MAXR;
		;
quit;




proc reg data=cereal_ds outest=est_cereal;
	model 
rating = sugars fiber shelf sodium fat protein carbo calories vitamins 
	/ dwProb pcorr1 VIF noint stb selection=forward;
	OUTPUT OUT=reg_cerealOUT PREDICTED= 	RESIDUAL=Res L95M=C_195m U95=C_u95m  L95=C_l95 U95=C_u95
	rstudent=C_rstudent h=lev cookd=Cookd dffits=dffit
	STDP=C-spredicted STDR=C_s_residual STUDENT=C-student ;
	;
quit;
