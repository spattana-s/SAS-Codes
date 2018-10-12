*-------------------------------------------------------------------------;
* Project        : ANOVA                            ;
* Developer(s)   : Khasha Dehand                                          ;
* Comments       :                                     ;
*-------------------------------------------------------------------------;



data sales;
infile datalines;
input channel $10. sales ;
datalines;
channel_1          5
channel_1          3
channel_1 	       10
channel_1 	       6
channel_2 	       10
channel_2	       15
channel_2	        8
channel_2	        7
channel_3 	       23
channel_3 	       18
channel_3 	       16
channel_3 	       11
;
run;


proc univariate data=sales;
var sales;
run;

proc anova data=sales;
	class channel;
	model sales = channel;
run;


libname sas_data "C:\Users\sanja\Google Drive\2ndSem\BIA672_MarketingAnalytics_KashaDehnad\SAS_Data";
run;


proc copy in=sas_data out=work;
	select vehicles;
run;

title1 "Sales of Passenger Cars";
proc sgplot data=vehicles;
	series x=period y=vehicles / markers;
run;


proc forecast data=vehicles
		method=expo lead=12
		out=out_expo outfull outresid outest=est_expo;
	id period;
	var vehicles;
run;


title1 "Sales of Passenger Cars";
title2 "Plot of residuals";

proc sgplot data=out_expo;
	where _type_="RESIDUAL" and period>200;
	needle x=period y=vehicles / markers markerattrs=(symbol=circlefilled);
run;




title1 "Sales of Passenger Cars";
proc sgplot data=vehicles;
   series x=period y=vehicles / markers;
   
run;
proc forecast data=vehicles 
              method=expo lead=12
              out=out_expo outfull outresid outest=est_expo;
   id period;
   var vehicles;
   
run;

title1 "Sales of Passenger Cars";
title2 'Plot of Residuals';
proc sgplot data=out_expo;
   where _type_ = 'RESIDUAL' and period>200;
   needle x=period y=vehicles / markers markerattrs=(symbol=circlefilled);
   
run;
title1 "Sales of Passenger Cars";
title2 'Plot of Forecast from WINTERS Method';
proc sgplot data=out;
   series x=period y=vehicles / group=_type_ lineattrs=(pattern=1);
   where _type_ ^= 'RESIDUAL' and period>230;
   
run;


proc forecast data=vehicles 
              method=winters seasons=12  lead=12
              out=out_winters outfull outresid outest=est;
   id period;
   var vehicles;
   
run;
*;

title1 "Sales of Passenger Cars";
title2 'Plot of Forecast from WINTERS Method';
proc sgplot data=out_winters;
   series x=period y=vehicles / group=_type_ lineattrs=(pattern=1);
   where _type_ ^= 'RESIDUAL' and  period>200;
   
run;

