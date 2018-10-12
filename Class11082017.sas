*The following statement copies the file in a directory or folder
to the output directory or folder;
proc copy in=sashelp out=work;
select iris;
run;

/*1. Regression Model SepalLength on Petal length and Width
2. Scatter plot to check corelation
3. Correlation for variance


*/

* The command line does a regression on the varibales or predictors y= x1 x2 ... VIF-variable inflation factor
is the value that shows the effect of Collinearity(multiple vriables have same effect or are corelated)
VIF ranges are
<5 Very good i.e not colliner or not correlated
5<VIF<10 some what ok or manageable
10< Problem ie variables are highly collinear;
proc reg data=iris;
model SepalLength=PetalWidth PetalLength / vif dwProb STB;
run;

* the plots and allipse help in identifying the correlation or collinearity i.e as a varibale
value increases/decreases the other value also increases/decreases;
proc sgplot  data =iris;
scatter x=PetalWidth y=PetalLength;
run;


proc sgplot  data =iris;
scatter x=PetalWidth y=PetalLength;
ellipse x=PetalWidth y=PetalLength;
run;


proc sgplot  data =iris;
ellipse x=PetalWidth y=PetalLength;
run;

proc corr data=iris cov;
var PetalWidth PetalLength;
run;


*Procedure STANDARD standardizes variables, normalizes and standardizes
Satndardize means makes the values near to the mean. I.e the below command makes MEAN=0 and STD(standard deviation)=1;

PROC STANDARD data = iris(keep= SepalLength species PetalWidth PetalLength) MEAN=0 STD=1
OUT=iris_z(rename=(PetalWidth=PetalWidth_z PetalLength=PetalLength_z));
VAR PetalWidth PetalLength;
run;

proc univariate data=iris_z;
var PetalWidth_z PetalLength_z;
run;


proc princomp data=iris_z;
var PetalWidth_z PetalLength_z;
run;


proc princomp data=iris_z out=pca_petal;
var PetalWidth_z PetalLength_z;
run;


file='C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data\HW_Reg6.9.pdf';
title "Analysis for Depression Problem6.9";
PROC IMPORT OUT= WORK.depression 
            DATAFILE= "C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\S
AS_KashaDehnad\SAS_data\depression.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

proc corr data=depression;
var c1-c20;
run;


PROC STANDARD data = depression MEAN=0 STD=1
OUT=depression_z;
VAR c1-c20;
run;

proc princomp data=depression_z out=depression_pca;
var c1-c20;
run;
