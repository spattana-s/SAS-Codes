PROC IMPORT OUT= WORK.Zip_income 
            DATAFILE= "C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\S
AS_KashaDehnad\SAS_data\zipcodeagi13.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;


*IRS Dataset work;
/*Nogoood zip=0000 or 9999
NJzip zip=NJ
NYzip zip=NY
Rest zip=all other
STATE ZIPCODE AGI_STUB N1 A02650*/


data Nogood NJzip NYzip rest;
	set Zip_income(keep=STATEFIPS STATE ZIPCODE AGI_STUB N1 A02650);
	if zipcode='00000' or zipcode='99999' then output Nogood;
	else if state='NJ' then output NJzip;
	else if state='NY' then output NYzip;
	else output Rest;
run;


Libname sasdata "C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data" access=read;

Libname sasdata "C:\Users\sanja\Google Drive (spattana@stevens.edu)\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data" access=read;


proc datasets libname=sasdata;
run;

proc contents data=sasdata.STRESS_TEST;
run;

proc copy in=sasdata out=work;
	select STRESS_TEST STRESS_PATIENTS;
run;


/*Merge/Combine files to give one file*/

proc sort data=STRESS_PATIENTS out=STRESS_PATIENTS2; 
	by Patient_ID;
run;


proc sort data=STRESS_TEST out=STRESS_TEST2; 
	by Patient_ID;
run;


data both;
	merge STRESS_PATIENTS 
	STRESS_TEST
	;
run;


data both;
	merge STRESS_PATIENTS 
	STRESS_TEST
	;
	by Patient_ID;
run;




proc sql;
	create table both_sql as
	select a.*
	,b.*
	from STRESS_PATIENTS a
	,STRESS_TEST b
	where a.Patient_ID = b.Patient_ID
	;
	quit;


proc sort data=STRESS_PATIENTS out=STRESS_PATIENTS2 nodupkey; 
	by Patient_ID;
run;

proc sort data=STRESS_TEST out=STRESS_TEST2 nodupkey; 
	by Patient_ID;
run;


data both;
	merge STRESS_PATIENTS2 
	STRESS_TEST2
	;
	by Patient_ID;
run;


proc sql;
	create table both_sql as
	select a.*
	,b.*
	from STRESS_PATIENTS2 a
	,STRESS_TEST2 b
	where a.Patient_ID = b.Patient_ID
	;
	quit;


data both;
	merge STRESS_PATIENTS2(in=infirst) 
	STRESS_TEST2(in=insecond)
	;
	by Patient_ID;
	if infirst and insecond then output;
run;

data both notest;
	merge STRESS_PATIENTS2(in=infirst) 
	STRESS_TEST2(in=insecond)
	;
	by Patient_ID;
	if infirst and insecond then output both;
	else if infirst and not insecond then output notest;
run;



data both notest;
	merge STRESS_PATIENTS2(in=infirst) 
	STRESS_TEST2(in=insecond)
	;
	by Patient_ID;
	dsn1=infirst; *program data vector PDV;
	dsn2=insecond;
	if infirst and insecond then output both;
	else if infirst and not insecond then output notest;
run;


data both notest;
drop TimeMin TimeSec;
retain cum_sec;
	merge STRESS_PATIENTS2(in=infirst) 
	STRESS_TEST2(in=insecond)
	;
	by Patient_ID;
	total_sec=TimeMin*60+TimeSec;
	cum_sec=cum_sec+total_sec;
	if infirst and insecond then output both;
	else if infirst and not insecond then output notest;
run;

data both;
set both;
drop cum_sec;
drop drop;
run;


data both2;
retain cum_sec;
	set both;
	if _n_=1 then cum_sec=0;
	*by Patient_ID;
	cum_sec=cum_sec+total_sec;
	run;


data both2;
retain cum_sec 0;
	set both;
	*if _n_=1 then cum_sec=0;
	*by Patient_ID;
	cum_sec=cum_sec+total_sec;
	run;

	*Output if not used then the current table/dataset is overwritten;
proc sort data=both; 
	by Tolerance; 
run;


data both2;
*retain cum_sec 0;
	set both;
	by Tolerance;
	var1=first.Tolerance;
	var2=last.Tolerance;
	*if first.Tolerance then cum_sec=0;
	else 
	output;
	run;


	data both2;
retain cum_sec;
	set both;
	by Tolerance;
	if first.Tolerance then cum_sec=0;
	cum_sec=cum_sec+total_sec; 
	output;
	run;


data work.earn(drop=i);
investment=1000;
payment=10;
do i=1 to 30;
interest=investment*.05;
year+1;
investment+interest;
output;
end;
run;


data junk;
do;
x=1;
y=20;
z='this is a test';
output;
end;
run;

proc sort data=Njzip;
by zipcode;
run;

data Njzip2;
set Njzip;
by zipcode;
	var1=first.zipcode;
	var2=last.zipcode;
		output;
	run;


	data Njzip3;
retain total_count;
retain total_money;
set Njzip;
by zipcode;
	if first.zipcode then total_count=0;
	total_count=total_count+N1; 
	if first.zipcode then total_money=0;
	total_money=total_money+A02650; 
	if last.zipcode then do average=total_money/total_count;
		output;
		end;
		run;

		
	data Njzip2;
retain total_money;
set Njzip;
by zipcode;
	if first.zipcode then total_money=0;
	total_money=total_money+A02650; 
		output;
	run;


	*Average;

data Njzip3;
*retain average;
set Njzip2;
by zipcode;
	if last.zipcode then average=0;
	average=total_money/total_count; 
		output;
	run;




	proc sort data=NJzip; by zipcode agi_stub; run;

	data njzip;
	keep state zipcode N1 A02650;
	set income_by_zip;
	if zipcode=0 or zipcode=99999 then delete;
	if state='NJ' then output njzip;
	run;

	proc sort data=NJzip; by zipcode agi_stub; run;

	data nj_smmary;
	retain total_count total_money;
	keep zipcode total_count total_money average;
	set NJzip;
	by zipcode;
	if zipcode=0 or zipcode=99999 then delete;
	if first.zipcode then do;
	total_count=0;
	total_money=0;
	end;
	total_count=total_count+n1;
	total_money=total_money+A02650;
	if last.zipcode then do;
	average=total_money/total_count;
	output;
	end;
	run;


%let st=NY;

%macro mzipmoney(st=NJ);
data &st.zip;
	keep state zipcode agi_stub N1 A02650;
	set Zip_income;
	if zipcode=0 or zipcode=99999 then delete;
	if state="&st." then output &st.zip;
	run;
	* single quote exact match, double quote variable example & usge ;

	proc sort data=&st.zip; by zipcode agi_stub; run;

	data &st._smmary;
	retain total_count total_money;
	keep zipcode total_count total_money average;
	set &st.zip;
	by zipcode;
	if zipcode=0 or zipcode=99999 then delete;
	if first.zipcode then do;
	total_count=0;
	total_money=0;
	end;
	total_count=total_count+n1;
	total_money=total_money+A02650;
	if last.zipcode then do;
	average=total_money/total_count;
	output;
	end;
	title "This is processing for state of &st. "; *nothing next to &st then dot not mandatory;
	proc print data=&st.summary;
	var zipcode total_count total_money average;
	run;
%mend;	

%mzipmoney(st=AL);


%mzipmoney *calculates for NJ;
