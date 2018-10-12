*-------------------------------------------------------------------------;
* Project        :  BIA672   Marketing Analytics                          ;
* Developer(s)   : Khasha Dehand                                          ;
* Comments       : forecasting Problem                               ;
*-------------------------------------------------------------------------;



 

title1 "Sales of Passenger Cars";
proc sgplot data= Vehicles;
   series x=period y=vehicles / markers;
   
run;

*** holt winters method  **;
proc forecast data=Vehicles seasonal=12
              method=winters   lead=6 
              out=Fcast_Vehicles outfull outresid outest=Fcast_est_Veh;
   var vehicles;
   id  period;  
run;

proc sgplot data=Fcast_Vehicles(where=(period>=200)) ;
   series x=period y=vehicles  / group=_type_ ;
   where _type_ ^= 'RESIDUAL';
     
run;
*** Double Exp. smoothing  **;
proc forecast data=Vehicles  
              method=winters   lead=6 
              out=Fcast_Vehicles outfull outresid outest=Fcast_est_Veh;
   var vehicles;
   id  period;  
run;

proc sgplot data=Fcast_Vehicles(where=(period>=200)) ;
   series x=period y=vehicles  / group=_type_ ;
   where _type_ ^= 'RESIDUAL';
     
run;

***  Exp. smoothing  **;
proc forecast data=Vehicles  
              method=expo   lead=6 
              out=Fcast_Vehicles outfull outresid outest=Fcast_est_Veh;
   var vehicles;
   id  period;  
run;

proc sgplot data=Fcast_Vehicles(where=(period>=200)) ;
   series x=period y=vehicles  / group=_type_ ;
   where _type_ ^= 'RESIDUAL';
     
run;

