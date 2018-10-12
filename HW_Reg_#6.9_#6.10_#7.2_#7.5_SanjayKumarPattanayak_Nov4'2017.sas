/*Problem 6.9;*/
ods pdf
file='C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data\HW_Reg6.9.pdf';
title "Analysis for Depression Problem6.9";
PROC IMPORT OUT= WORK.depression 
            DATAFILE= "C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\S
AS_KashaDehnad\SAS_data\depression.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

data Depression2;
	set Depression(keep = ID AGE INCOME);
run;

proc univariate data=Depression2;
var AGE INCOME;
run;

proc sort data=Depression2;
by AGE;
run;

proc sgplot data=Depression2;
scatter x=AGE y=INCOME;
ellipse x=AGE y=INCOME;
run;

proc reg data=Depression2 outest=est;
model INCOME= AGE;
run;


	proc sql;
	INSERT INTO Depression2 values (295, 42, 120);
	quit;

	proc sort data=Depression2;
by AGE;
run;


proc reg data=Depression2 outest=est1;
model INCOME= AGE;
run;

proc sql;
	DELETE FROM Depression2 WHERE Depression2.ID=295;
	quit;

proc sql;
	INSERT INTO Depression2 values (295, 80, 150);
	quit;

	proc sort data=Depression2;
by AGE;
run;


proc reg data=Depression2 outest=est2;
model INCOME= AGE;
run;

proc sql;
	DELETE FROM Depression2 WHERE Depression2.ID=295;
	quit;

proc sql;
	INSERT INTO Depression2 values (295, 180, 15);
	quit;

	proc sort data=Depression2;
by AGE;
run;


proc reg data=Depression2 outest=est3;
model INCOME= AGE;
run;

proc sql;
	DELETE FROM Depression2 WHERE Depression2.ID=295;
	quit;

ods pdf close;


/*Problem 6.10*/

ods pdf
file='C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data\HW_Reg6.10.pdf';
title "Analysis for Lung Problem6.10";

libname sas_data "C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data" 
access=read;
run;

proc copy in=sas_data out=work;
select lung;
run;

proc sort data=lung;
by Weight_oldest_child;
run;

proc reg data=lung outest=est;
model FEV1_oldest_child= Weight_oldest_child;
run;

proc sort data=lung;
by Height_oldest_child;
run;

proc reg data=lung outest=est1;
model FEV1_oldest_child= Height_oldest_child;
run;

proc sort data=lung;
by Weight_oldest_child;
run;

proc reg data=lung outest=est3;
model FVC_oldest_child= Weight_oldest_child;
run;

proc sort data=lung;
by Height_oldest_child;
run;

proc reg data=lung outest=est4;
model FVC_oldest_child= Height_oldest_child;
run;

ods pdf close;

/*Problem 7.2*/

ods pdf
file='C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data\HW_Reg7.2.pdf';
title "Problem 7.2 Reg of FFVC against Age and Height";


libname sas_data "C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data" 
access=read;
run;

proc copy in=sas_data out=work;
select lung;
run;

proc corr data=lung cov;
var FVC_father Age_Father Height_father;
run;


proc reg data=lung outest=est;
model FVC_father= Age_father Height_father ;
OUTPUT OUT=reg_lungoUT h=lev cookd=Cookd  dffits=dffit;
plot FVC_father* Age_father* Height_father='*';/*Have not drawn this yet*/
run;

ods pdf close;

/*Problem 7.5*/


ods pdf
file='C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data\HW_Reg7.5.pdf';
title "Problem 7.5 Regression Analysis CESD against INCOME, SEX, & AGE";
PROC IMPORT OUT= WORK.depression 
            DATAFILE= "C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\S
AS_KashaDehnad\SAS_data\depression.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;


data Depression2;
	set Depression;
run;

proc sort data=Depression2;
by AGE;
run;


  proc reg data=Depression2 outest=est;
model CESD= AGE INCOME SEX;
OUTPUT OUT=reg_lungoUT h=lev cookd=Cookd  dffits=dffit;
run;


ods pdf close;
