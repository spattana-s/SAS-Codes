/*Problem 6.9;*/
ods rtf
file='C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data\HW_Reg6.9.rtf';
title "Analysis for Depression Problem6.9";
*"Import Data from File";
PROC IMPORT OUT= WORK.depression 
            DATAFILE= "C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\S
AS_KashaDehnad\SAS_data\depression.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
*Make a copy of Main file and keep only variables needed;
data Depression2;
	set Depression(keep = ID AGE INCOME);
run;
*Sort by Age/Just a good habit;
proc sort data=Depression2;
	by AGE;
run;

*Regression of Income on Age;
title "Regression model of Income on Age";
proc reg data=Depression2;
model INCOME= AGE;
OUTPUT out=est h=lev cookd=Cookd;
plot INCOME*AGE='*';
run;


title "Plot Income vs Age for original data set";
proc sgplot data=Depression2;
scatter x=AGE y=INCOME / datalabel=INCOME;
ellipse x=AGE y=INCOME;
run;

*SQL command to insert 1st data;

proc sql;
	INSERT INTO Depression2 values (295, 42, 120);
quit;

*sorting by age again;
proc sort data=Depression2;
	by AGE;
run;

*Regression model with added data;
title "Regression model with 1st set of external data addition";
proc reg data=Depression2;
	model INCOME= AGE;
	OUTPUT out=est_1 student=res_1 h=lev cookd=Cookd dffits=dffits;
run;

data est_1; set est_1;
  resid_sq = res_1*res_1;
run;

proc sgplot data = est_1;
  scatter y = cookd x = resid_sq / datalabel = INCOME;
run;


*to find the impact of new data;
proc print data=est_1;
	where cookd>4/295;
run;

*plotting to see the effect of new data;
proc sgplot data=Depression2;
	scatter x=AGE y=INCOME / datalabel=INCOME;
	ellipse x=AGE y=INCOME;
run;

*deleting the added data;
proc sql;
	DELETE FROM Depression2 WHERE Depression2.ID=295;
quit;

*Inserting 2nd data values into the table;
proc sql;
	INSERT INTO Depression2 values (295, 80, 150);
quit;

*Sorting;
proc sort data=Depression2;
	by AGE;
run;


*Regression model with added data;
title "Regression model with 1st set of external data addition";
proc reg data=Depression2;
	model INCOME= AGE;
	OUTPUT out=est_2 student=res_2 h=lev cookd=Cookd dffits=dffits;
run;


data est_2; set est_2;
  resid_sq = res_2*res_2;
run;

proc sgplot data = est_2;
  scatter y = cookd x = resid_sq / datalabel = INCOME;
run;


*to find the impact of new data;
proc print data=est_2;
	where cookd>4/295;
run;

*plotting to see the effect of new data;
proc sgplot data=Depression2;
	scatter x=AGE y=INCOME / datalabel=INCOME;
	ellipse x=AGE y=INCOME;
run;

*deleting the added data;
proc sql;
	DELETE FROM Depression2 WHERE Depression2.ID=295;
quit;

*Inserting 3rd dataset;
proc sql;
	INSERT INTO Depression2 values (295, 180, 15);
quit;

*Sorting;
proc sort data=Depression2;
	by AGE;
run;



*Regression model with added data;
title "Regression model with 1st set of external data addition";
proc reg data=Depression2;
model INCOME= AGE;
OUTPUT out=est_3 student=res_3 h=lev cookd=Cookd dffits=dffits;
run;


data est_3; set est_3;
  resid_sq = res_3*res_3;
run;

proc sgplot data = est_3;
  scatter y = cookd x = resid_sq / datalabel = INCOME;
run;


*to find the impact of new data;
proc print data=est_3;
where cookd>4/295;
run;

*plotting to see the effect of new data;
proc sgplot data=Depression2;
scatter x=AGE y=INCOME / datalabel=INCOME;
ellipse x=AGE y=INCOME;
run;

*deleting the added data;
proc sql;
	DELETE FROM Depression2 WHERE Depression2.ID=295;
quit;

ods rtf close;


/*Problem 6.10*/

ods rtf
file='C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data\HW_Reg6.10.rtf';
title "Analysis for Lung Problem6.10";
*creating library;
libname sas_data "C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data" 
access=read;
run;
*copying file in library=sas_data to work folder;
proc copy in=sas_data out=work;
select lung;
run;

*Correlation among FEV1_oldest_child FVC_oldest_child Height_oldest_child Weight_oldest_child;
title "Correlation of 4 variables";
proc corr data=lung ;
var FEV1_oldest_child FVC_oldest_child Height_oldest_child Weight_oldest_child;
run;


*sorting as per weight of oldest child;
proc sort data=lung;
by Weight_oldest_child;
run;

*regression of FEV1 of oldest child against Weight of oldest child;
title "regression of FEV1 of oldest child against Weight of oldest child";
proc reg data=lung outest=est;
model FEV1_oldest_child= Weight_oldest_child;
run;

*sorting by height of oldest child;
proc sort data=lung;
by Height_oldest_child;
run;


*regression of FEV1 of oldest child against Height of oldest child;
title "Regression of FEV1 of oldest child against Height of oldest child";
proc reg data=lung outest=est1;
model FEV1_oldest_child= Height_oldest_child;
run;

*sorting by Weight of oldest child;
proc sort data=lung;
by Weight_oldest_child;
run;

*regression of FVC of oldest child against Weight of oldest child;
title "Regression of FVC of oldest child against Weight of oldest child";
proc reg data=lung outest=est3;
model FVC_oldest_child= Weight_oldest_child;
run;

*sorting by Height;
proc sort data=lung;
by Height_oldest_child;
run;


*regression of FVC of oldest child against Height of oldest child;
title "Regression of FVC of oldest child against Height of oldest child";
proc reg data=lung outest=est4;
model FVC_oldest_child= Height_oldest_child;
run;

ods rtf close;

/*Problem 7.2*/

ods rtf
file='C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data\HW_Reg7.2.rtf';
title "Problem 7.2 Reg of FFVC against Age and Height";

*Getting the file from Library "SAS_dt";
libname sas_data "C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data" 
access=read;
run;

proc copy in=sas_data out=work;
select lung;
run;

*Correlation between FVC_father Age_Father Height_father;
proc corr data=lung cov;
var FVC_father Age_Father Height_father;
run;

*Regression model of FVC_father upon Age_father Height_father;
proc reg data=lung outest=est;
model FVC_father= Age_father Height_father ;
OUTPUT OUT=reg_lungoUT h=lev cookd=Cookd  dffits=dffit;
plot FVC_father* Age_father* Height_father='*';/*Have not drawn this yet*/
run;

ods rtf close;

/*Problem 7.5*/


ods rtf
file='C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data\HW_Reg7.5.rtf';
title "Problem 7.5 Regression Analysis CESD against INCOME, SEX, & AGE";
*Getting the file into Work Folder;
PROC IMPORT OUT= WORK.depression 
            DATAFILE= "C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\S
AS_KashaDehnad\SAS_data\depression.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

*creating a duplicate file to work on;
data Depression2;
	set Depression;
run;

*sorting for good practice;
proc sort data=Depression2;
by AGE;
run;

*Regression CESD upon AGE INCOME SEX;
  proc reg data=Depression2 outest=est;
model CESD= AGE INCOME SEX;
OUTPUT OUT=reg_lungoUT PREDICTED=predict   RESIDUAL=res   L95M=l95m  U95M=u95m  L95=l95 U95=u95
       rstudent=rstudent h=lev cookd=Cookd  dffits=dffit;
run;


ods rtf close;

