







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
