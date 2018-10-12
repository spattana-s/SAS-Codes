*-------------------------------------------------------------------------;
* Project        :  Marketing Analytics                                         ;
* Developer(s)   :  Khasha Dehand                                         ;
* Comments       :  Solution to Homework Problem                    ;
*-------------------------------------------------------------------------;
*-------------------------------------------------------------------------;
* Step 1        :   import data                                        ;
*  
*-------------------------------------------------------------------------;


PROC IMPORT OUT= WORK.WalMart 
            DATAFILE= "C:\AIMS\Stevens_\2018_Marketing_Analytics\Raw_dat
a\WallMart_store_sales.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

data WalMart2;
    set WalMart;
    if store=1 and dept=1;
run; 




title1 "Sales of WalMar Store 1 Department 1";
proc sgplot data=WalMart2 ;
   series x=date y=Weekly_Sales/;
  
run;
proc forecast data=WalMart2 
              method=expo    lead=6 
              out=Fcast_out_expo outfull outresid outest=Fcast_est_expo;
   var Weekly_Sales ;
   ID date ;
run;

title1 "Sales of WalMar Store 1 Department 1";
title2 'Plot of Forecast from Expo Method';
proc sgplot data=Fcast_out_expo;
   series x=date y=Weekly_Sales / group=_type_ ;
   where _type_ ^= 'RESIDUAL';
  
run;


proc forecast data=WalMart2 
              method=winters  lead=6 
              out=Fcast_out_Dexpo outfull outresid outest=Fcast_est_Dexpo;
   var Weekly_Sales ;
   ID date ;
run;

title1 "Sales of WalMar Store 1 Department 1";
title2 'Plot of Forecast from Expo Method';
proc sgplot data=Fcast_out_Dexpo ;
   series x=date y=Weekly_Sales / group=_type_ ;
   where _type_ ^= 'RESIDUAL';
  
run;

proc forecast data=WalMart2 season=8
              method=winters  lead=6 
              out=Fcast_out_season outfull outresid outest=Fcast_est_season ;
   var Weekly_Sales ;
   ID date ;
run;

title1 "Sales of WalMar Store 1 Department 1";
title2 'Plot of Forecast from Winters Season=13 Method';
proc sgplot data=Fcast_out_season  ;
   series x=date y=Weekly_Sales / group=_type_ ;
   where _type_ ^= 'RESIDUAL';
  
run;
