ods pdf;

title"Price Elasticity Models for 18 pack and 30 pack weekly beer sales";
*Cretae libirary name from where the raw SAS data file can be read;
libname sas_data "C:\Users\sanja\Google Drive\2ndSem\BIA672_MarketingAnalytics_KashaDehnad\SAS_Data" 
access=read;
run;

*Copy the data file from sytem library to Work library;
proc copy in = sas_data out = work;
select beer_sales;
run;

*Filter the data so that rows with valid values are selected, store the values in new table;
data beer_sales_b;
	set beer_sales;
	if week<=52;
	run;

*Sort the data as good practice, helps in getting proper reading in graph;
proc sort data=beer_sales_b; by price_30pk;run;

title2"SGPlot of Demand/Price - Non-log values - 30 pack";
*Plot the graph to see the distribution;
proc sgplot data=beer_sales_b;
series x=Price_30PK y=cases_30pk;
run;


title2"Regression of Demand/Price - Non-log values - 30 pack";
*Regression Procedure to see the affect of Price on Demand;
proc reg data=beer_sales_b;
model cases_30pk = price_30pk;
run;
quit;

*The folowing command can be used to get log value, In this case the values are already converted;
/*
data beer_sales_b;
	set beer_sales;
	if week<=52;
	*price_12pk_ln=log(price_12pk);
	run;
*/


title2"SGPlot of Demand/Price - Log values - 30 pack";
*Plot the logarithmic value graph to see the distribution;
proc sgplot data=beer_sales_b;
series x=Price_30PK_ln y=cases_30pk_ln;
run;


title2"Regression of Demand/Price - Log values - 30 pack";
*Regression Procedure of logarithmic value to see the affect of Price on Demand;
proc reg data=beer_sales_b;
model cases_30pk_ln = price_30pk_ln;
run;
quit;



*Filter the data so that rows with valid values are selected, store the values in new table;
data beer_sales_c;
	set beer_sales;
	if week<=52;
	run;


*Sort the data as good practice, helps in getting proper reading in graph;
proc sort data=beer_sales_c; by price_18pk;run;


title2"SGPlot of Demand/Price - Non-Log values - 18 pack";
*Plot the graph to see the distribution;
proc sgplot data=beer_sales_c;
series x=Price_18PK y=cases_18pk;
run;


title2"Regression of Demand/Price - Non-Log values - 18 pack";
*Regression Procedure to see the affect of Price on Demand;
proc reg data=beer_sales_c;
model cases_18pk = price_18pk;
run;
quit;


title2"SGPlot of Demand/Price - Log values - 18 pack";
*Plot the logarithmic value graph to see the distribution;
proc sgplot data=beer_sales_c;
series x=Price_18PK_ln y=cases_18pk_ln;
run;

title2"Regression of Demand/Price - Log values - 18 pack";
*Regression Procedure of logarithmic value to see the affect of Price on Demand;
proc reg data=beer_sales_c;
model cases_18pk_ln = price_18pk_ln;
run;
quit;


ods pdf close;
