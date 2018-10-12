ods pdf;

/*
1. Import data into SAS work folder
2. Filter VIRGINIA data.
3. Filter outliers and blank rows(PIN-0 or 99999)
4. Make categories of income(6 categories)
5. Perform clustering (a)Hirerchial (b)K-Means 
*/


*Imports CSV data into WORK folder;
PROC IMPORT OUT= WORK.Income_byZIP_2015 
            DATAFILE= "C:\Users\sanja\Google Drive\2ndSem\BIA672_Marketi
ngAnalytics_KashaDehnad\RAW-Data\15zpallagi.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

*Segregates data into Virginia data/Rest data/Junk data - Keeps only columns necessary;
data Income_2015_VA Income_2015_rest junk;
keep STATEFIPS zipcode State agi_stub N1;
 set Income_byzip_2015;
 if zipcode = 0 or zipcode = 99999 then output junk;
 else if state = "VA" then output Income_2015_VA;
 else output Income_2015_rest;
run;


*Formats the categorization/segmentation of income slabs;
proc format;
   value  agifmt
        1 = '$1 under $25,000       '
		2 = '$25,000 under $50,000  '
		3 = '$50,000 under $75,000  '
		4 = '$75,000 under $100,000 '
		5 = '$100,000 under $150,000'
		6 = '$150,000 or more       '        
       other='Unkown                '
       ;

run;



*Sorts the Virginia data by ZIPCode;
proc sort data=income_2015_va;by zipcode;run;


*Segments/Formats Virginia data as per categorization/segmentation of income slabs;
data agi1 agi2 agi3 agi4 agi5 agi6 empty;
set  income_2015_va(rename=(n1=Returns));
     if AGI_STUB=1 then output  agi1;
else if AGI_STUB=2 then output  agi2;
else if AGI_STUB=3 then output  agi3;
else if AGI_STUB=4 then output  agi4;
else if AGI_STUB=5 then output  agi5;
else if AGI_STUB=6 then output  agi6;
else output empty;
run;


*Merges the 6 segmented tables as one for further clustering;
data agi_all;
  merge agi1(rename= (Returns=Returns1) drop=AGI_STUB) 
        agi2(rename= (Returns=Returns2) drop=AGI_STUB) 
        agi3(rename= (Returns=Returns3) drop=AGI_STUB)   
        agi4 (rename= (Returns=Returns4) drop=AGI_STUB) 
        agi5 (rename= (Returns=Returns5) drop=AGI_STUB) 
         agi6 (rename= (Returns=Returns6) drop=AGI_STUB)  ; 
  by STATEFIPS state zipcode;
run;


*Calculates the percent of exach slab in each ZIPCode;
data zip_income_pct;
drop i;
 set agi_all;
  array  Returns_pcts  {6}  Returns_pct1 -  Returns_pct6 ;
  array  Returns  Returns1 - Returns6   ;
  total=sum(of Returns1 - Returns6);
  do i=1 to 6;
     Returns_pcts[i]=round((Returns[i]/total)*100,.01);
  end;
run;


*K-Means Clusterization;
Title "K-Means Clusterization";

proc fastclus data =zip_income_pct  
      maxclusters =10 out=kmeans_zip_income_pct; 
var Returns_pct1 Returns_pct2 Returns_pct3 Returns_pct4 Returns_pct5 Returns_pct6  ;
id  zipcode ;
run;

proc sort data=kmeans_zip_income_pct;
by cluster;
run;


proc print data=kmeans_zip_income_pct;
by cluster;
var zipcode Returns_pct1 Returns_pct2 Returns_pct3 Returns_pct4 Returns_pct5 Returns_pct6;
run;



*Hirerchial Clusterization;
Title "Hirerchial Clusterization";

proc cluster data = zip_income_pct outtree=hirerchial_zip_income_pct method=SINGLE;         
var Returns_pct1 Returns_pct2 Returns_pct3 Returns_pct4 Returns_pct5 Returns_pct6  ;
id  zipcode ;
run;



proc tree data = hirerchial_zip_income_pct ncl=10 out=out;
   copy zipcode;
run;


ods pdf close;
