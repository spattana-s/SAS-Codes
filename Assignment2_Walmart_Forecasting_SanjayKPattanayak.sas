ods pdf;

*Import data into Work folder;
PROC IMPORT OUT= WORK.Walmart_Forecasting 
            DATAFILE= "C:\Users\sanja\Google Drive\2ndSem\BIA672_Marketi
ngAnalytics_KashaDehnad\RAW-Data\WallMart_store_sales.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

*Segregate data for Store 1 Dept1;
data Store1_Dept1 Walmart5_rest;
 set Walmart_Forecasting;
 if store = 1 and dept = 1 then output Store1_Dept1;
  else output Walmart5_rest;
run;


Title "Plot of the Weekly Sale";
proc sgplot data=Store1_Dept1;
	series x=Date y=Weekly_Sales / markers;
run;

*Exponential Forecast with lead of 12 periods;
proc forecast data=Store1_Dept1
		method=expo lead=12 trend=1
		out=out_expo_walmart outfull outresid outest=est_expo_walmart;
	id Date;
	var Weekly_Sales;
run;

Title "Exponential-Plot of the Error Between Forecast and Actual";
proc sgplot data=out_expo_walmart;
	where _type_="RESIDUAL" and Date>10/26/12;
	needle x=Date y=Weekly_Sales / markers markerattrs=(symbol=circlefilled);
run;


Title "Exponential-Plot Between Forecast and Actual";
proc sgplot data=out_expo_walmart;
   series x=date y=Weekly_Sales / group=_type_ lineattrs=(pattern=1);
   where _type_ ^= 'RESIDUAL' and Date>10/26/12;
   
run;

*Double Exponential Forecast with lead of 12 periods;
proc forecast data=Store1_Dept1
		method=expo lead=12 trend=2
		out=out_doubleexpo_walmart outfull outresid outest=est_expo_walmart;
	id Date;
	var Weekly_Sales;
run;

Title "Double Exponential-Plot of the Error Between Forecast and Actual";
proc sgplot data=out_doubleexpo_walmart;
	where _type_="RESIDUAL" and Date>10/26/12;
	needle x=Date y=Weekly_Sales / markers markerattrs=(symbol=circlefilled);
run;


Title "Double Exponential-Plot Between Forecast and Actual";
proc sgplot data=out_doubleexpo_walmart;
   series x=date y=Weekly_Sales / group=_type_ lineattrs=(pattern=1);
   where _type_ ^= 'RESIDUAL' and Date>10/26/12;
   
run;


*Seasonal Forecast "Season=4" with lead of 12 periods;
proc forecast data=Store1_Dept1 
              method=winters seasons=4  lead=12
              out=out_winters_walmart4 outfull outresid outest=est_walmart4;
   id date;
   var weekly_sales;
   
run;
*;

Title "Seasonal 4 -Plot of Error Between Forecast and Actual";
proc sgplot data=out_winters_walmart4;
	where _type_="RESIDUAL" and Date>10/26/12;
	needle x=Date y=Weekly_Sales / markers markerattrs=(symbol=circlefilled);
run;


Title "Seasonal 4-Plot Between Forecast and Actual";
proc sgplot data=out_winters_walmart4;
   series x=date y=weekly_sales / group=_type_ lineattrs=(pattern=1);
   where _type_ ^= 'RESIDUAL' and  Date>10/26/12;
   
run;


*Seasonal Forecast "Season=8" with lead of 12 periods;
proc forecast data=Store1_Dept1 
              method=winters seasons=8  lead=12
              out=out_winters_walmart8 outfull outresid outest=est_walmart8;
   id date;
   var weekly_sales;
   
run;
*;

Title "Seasonal 8 -Plot of Error Between Forecast and Actual";
proc sgplot data=out_winters_walmart8;
	where _type_="RESIDUAL" and Date>10/26/12;
	needle x=Date y=Weekly_Sales / markers markerattrs=(symbol=circlefilled);
run;


Title "Seasonal 8 -Plot Between Forecast and Actual";
proc sgplot data=out_winters_walmart8;
   series x=date y=weekly_sales / group=_type_ lineattrs=(pattern=1);
   where _type_ ^= 'RESIDUAL' and  Date>10/26/12;
   
run;


*Seasonal Forecast "Season=13" with lead of 12 periods;
proc forecast data=Store1_Dept1 
              method=winters seasons=13  lead=12
              out=out_winters_walmart13 outfull outresid outest=est_walmart13;
   id date;
   var weekly_sales;
   
run;
*;

Title "Seasonal 13 -Plot of Error Between Forecast and Actual";
proc sgplot data=out_winters_walmart13;
	where _type_="RESIDUAL" and Date>10/26/12;
	needle x=Date y=Weekly_Sales / markers markerattrs=(symbol=circlefilled);
run;


Title "Seasonal 13 -Plot Between Forecast and Actual";
proc sgplot data=out_winters_walmart13;
   series x=date y=weekly_sales / group=_type_ lineattrs=(pattern=1);
   where _type_ ^= 'RESIDUAL' and  Date>10/26/12;
   
run;


ods pdf close;
