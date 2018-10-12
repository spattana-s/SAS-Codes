*-------------------------------------------------------------------------;
* Project        :  BIA672  Marketing Analytics                       ;
* Developer(s)   : Khasha Dehand                                          ;
* Comments       : Soluition to price elaticity                  ;

*-------------------------------------------------------------------------;

*-------------------------------------------------------------------------;
* Step 1         :  Read in the data
*                   used import facilty to generate the sas code
*-------------------------------------------------------------------------;

proc copy in=sas_data out=work;
select Beer_sales;
run;

*-------------------------------------------------------------------------;
* Step 2         :  Create dataset with log of demand
*-------------------------------------------------------------------------;

data BEER_SALES_b;
  set BEER_SALES;
  if week<=52;
 run;

*-------------------------------------------------------------------------;
* Step 3         :  plot the data and decide on the model
*                   use one macro variable (pkg) at a time.
*-------------------------------------------------------------------------;
*%let pkg=12PK;
*%let pkg=18PK;
%let pkg=30PK;
%let lg=_ln;
*%let lg=;

title "Reg Estimates  &pkg.&lg. vs. CASES_&pkg.&lg. ";
proc sort data=BEER_SALES_b; by Price_&pkg.&lg.;run;
proc sgplot data=BEER_SALES_b ;
   series x=Price_&pkg.&lg.   y=CASES_&pkg.&lg.;
run;



*-------------------------------------------------------------------------;
* Step 4         :  run a regression model to fit linear and log-linear 
*                   models 
*-------------------------------------------------------------------------;
title "Reg Estimates  &pkg.&lg. vs. CASES_&pkg.&lg. ";
proc reg data=BEER_SALES_b  ;
   model CASES_&pkg.&lg.=Price_&pkg.&lg.;
run;
quit; 

