
Title "This is result of Univarite PROC on income dataset";

proc univariate data=Income_byzip_2015;
	var zipcode;
run;

data Income_byzip_2015B;
 set Income_byzip_2015;
 if zipcode = 0 or zipcode = 99999 then delete;
run;

data Income_byzip_2015B junk;
 set Income_byzip_2015;
 if zipcode = 0 or zipcode = 99999 then output junk;
 else output Income_byzip_2015B;
run;


data Income_2015_NJ_NY Income_2015_rest junk;
 set Income_byzip_2015;
 if zipcode = 0 or zipcode = 99999 then output junk;
 else if state = "NJ" or state = "NY" then output Income_2015_NJ_NY;
 else output Income_2015_rest;
run;

data Income_2015_NJ_NY Income_2015_rest junk;
 keep STATEFIPS zipcode State agi_stub N1;
 set Income_byzip_2015;
 if zipcode = 0 or zipcode = 99999 then output junk;
 else if STATEFIPS = 34 or STATEFIPS = 36 then output Income_2015_NJ_NY;
 else output Income_2015_rest;
run;



Title "This is result of Univarite PROC on income dataset of States NJ and NY";

proc univariate data=Income_2015_NJ_NY;
	var zipcode;
run;


libname sas_data "C:\Users\sanja\Google Drive\2ndSem\BIA672_MarketingAnalytics_KashaDehnad\SAS_Data" access=read;
run;

proc copy in=work out=sas_data;
	select Income_2015_NJ_NY;
run;
/*
options user=sas_data; run;
The above command directs output to the specified folder. */

