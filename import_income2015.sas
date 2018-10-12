PROC IMPORT OUT= WORK.Income_byZIP_2015 
            DATAFILE= "C:\Users\sanja\Google Drive\2ndSem\BIA672_Marketi
ngAnalytics_KashaDehnad\RAW-Data\15zpallagi.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
