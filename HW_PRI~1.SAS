/*Problem Principal Component #14.1, #14.6, #14.7;*/
ods pdf
file='C:\Users\sanja\Desktop\SAS_KashaDehnad\SAS_data\HW_Principal Component_SanjayKPattanayak_#14.1_#14.6_#14.7.pdf';
title "principal components analysis on the last seven variables DRINK–CHRONILL Problem14.1";
PROC IMPORT OUT= WORK.depression 
            DATAFILE= "C:\Users\sanja\Desktop\SAS_KashaDehnad\SAS_data\depression.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

Title "Correlation between DRINK HEALTH REGDOC TREAT BEDDAYS ACUTEILL CHRONILL Problem14.1";
proc corr data=depression ;
var DRINK HEALTH REGDOC TREAT BEDDAYS ACUTEILL CHRONILL;
run;

Title "Principal Component Analysis on DRINK HEALTH REGDOC TREAT BEDDAYS ACUTEILL CHRONILL Problem14.1";
proc princomp data=depression out=depress_pca;
   	 var DRINK HEALTH REGDOC TREAT BEDDAYS ACUTEILL CHRONILL;
run;



title "Family lung function data define a new variable RATIO and do exploratory PCA Problem14.6";


libname sas_data "C:\Users\sanja\Desktop\SAS_KashaDehnad\SAS_data" 
access=read;
run;

proc copy in=sas_data out=work;
select lung;
run;



data LungPrinComp;
	set Lung;

	RATIO = FEV1_father / FVC_father;
run;

Title "Correlation between RATIO, FEV1_father Problem14.6";
proc corr data=LungPrinComp;
	var RATIO FEV1_father ;
run;

Title "Correlation between RATIO, FVC_father Problem14.6";
proc corr data=LungPrinComp;
	var RATIO FVC_father;
run;

Title "Correlation between RATIO, FEV1_father and FVC_father Problem14.6";
proc corr data=LungPrinComp;
	var RATIO FEV1_father FVC_father;
run;

Title "Principal Component Analysis on FEV1_father and FVC_father Problem14.6";
proc princomp data=LungPrinComp out=LungPCA;
	var FEV1_father FVC_father;
run;

Title "Plot of Principal Components of FEV1_father and FVC_father Problem14.6";
proc sgplot data=LungPCA; 
    scatter x = Prin1 y= Prin2 ;
    ellipse x = Prin1 y= Prin2;
quit;

Title "Principal Component Analysis on FEV1_father, FVC_father and RATIO Problem14.6" ;
proc princomp data=LungPrinComp out=LungPCA_ratio;
	var FEV1_father FVC_father RATIO;
run; 


title "Lung Function - Principal components analysis on age, height, and weight for the oldest child Problem14.7";

Title "Correlation between Age_oldest_child Height_oldest_child Weight_oldest_child Problem14.7";
proc corr data=LungPrinComp;
	var Age_oldest_child Height_oldest_child Weight_oldest_child;
run;


Title "Principal Component Analysis on Age_oldest_child Height_oldest_child Weight_oldest_child Problem14.7";
proc princomp data=Lung out=LungPCA;
	var Age_oldest_child Height_oldest_child Weight_oldest_child;
run;

ods pdf close;
