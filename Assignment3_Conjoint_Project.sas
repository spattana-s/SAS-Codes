ods pdf;

PROC IMPORT OUT= WORK.HW3_Conjoint 
            DATAFILE= "C:\Users\sanja\Google Drive\2ndSem\BIA672_MarketingAnalytics_KashaDehnad\Assignments
\Assignment3_Conjoint\HW03_conjoint_data.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

title "Preference for Laptop With Factors of Brand, Price, Screen Size, and Memory";
title2 "Metric Conjoint Analysis";
proc transreg data=HW3_Conjoint utilities ;
model identity(Rating)=class(Side	Entree	Special	Main/ zero=sum);*Utilities add up to zero;
run; 

ods pdf close;
