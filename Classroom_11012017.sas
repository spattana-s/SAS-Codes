*import churn;
libname sas_data "C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data";
*access=read;
run;
proc copy in=sas_data out=work;
select churn;
run;

Proc freq data=churn;
	tables churn VMail_Plan CustServ_Calls churn*VMail_Plan;
run;


Proc freq data=churn;
	tables churn VMail_Plan churn*VMail_Plan;
run;



data churn2;
	set churn;
		if churn="False." then V_churn=0;
		else V_churn=1;
		if VMail_Plan='yes' then V_voiceplan=1;
		else V_voiceplan = 0;
run;


Proc freq data=churn2;
	tables V_churn*V_voiceplan;
run;


proc logistic data=churn2 descending;
	class V_voiceplan(ref='0')/ param=ref;
	model V_churn = V_voiceplan;
quit;

proc logistic data=churn2 descending;
	class V_voiceplan(ref='1')/ param=ref;
	model V_churn = V_voiceplan;
quit;

data churn2;
	set churn;
		if churn="false." then V_churn=0;
		else V_churn=1;
		if VMail_Plan='yes' then V_voiceplan=1;
		else V_voiceplan=0;
if CustServ_Calls < 4 and CustServ_Calls > 1 then V_CSCtemp1=1;
	else V_CSCtemp1=0;
	if CustServ_Calls >= 4 then V_CSCtemp2=1;
	else V_CSCtemp2=0;
run;



proc logistic data=churn2 descending;
	class V_CSCtemp1(ref='0') V_CSCtemp2(ref='0') / param=ref;
	model V_churn = V_CSCtemp1 V_CSCtemp2;
quit;



data churn2;
	set churn;
		if churn="false." then V_churn=0;
		else V_churn=1;
		if VMail_Plan='yes' then V_voiceplan=1;
		else V_voiceplan=0;
if CustServ_Calls < 4 and CustServ_Calls > 1 then V_CSCtemp1=1;
	else V_CSCtemp1=0;
	if CustServ_Calls >= 4 then V_CSCtemp2=1;
	else V_CSCtemp2=0;
/*
	if CustServ_Calls < 2 then V_CSC=0;
		else if CustServ_Calls<4 then V_CSC=1;
		else V_CSC=2;
*/
if CustServ_Calls < 4 then V_CSC=0;
		else V_CSC=1;
run;



data churn2;
set churn;
if churn = "False." then V_churn=0;
else V_churn=1;
if VMail_Plan ='yes' then V_voiceplan = 1;
else V_voiceplan = 0;
if CustServ_Calls <4 and CustServ_Calls >1 then V_CSCtemp1 =1;
else V_CSCtemp1 =0;
if CustServ_Calls >=4 then V_CSCtemp2 =1;
else CSCtemp2 =0;


/*
	if CustServ_Calls < 2 then V_CSC=0;
		else if CustServ_Calls<4 then V_CSC=1;
		else V_CSC=2;
*/
if CustServ_Calls < 4 then V_CSC=0;
		else V_CSC=1;
run;

proc logistic data=churn2 descending;
	class V_CSC(ref='0')  / param=ref;
	model V_churn = V_CSC;
quit;


proc logistic data=churn2 descending;
	model V_churn = Day_Mins;
quit;



proc logistic data=churn2 descending;
	class  V_voiceplan(ref='0') V_CSC(ref='0') / param=ref;
	model V_churn = V_voiceplan V_CSC Account_Length Day_Mins Eve_Mins Night_Mins Intl_Mins;
quit;


proc logistic data=churn2 descending;
	class  V_voiceplan(ref='0') V_CSC(ref='0') / param=ref;
	model V_churn = V_voiceplan V_CSC  Day_Mins Eve_Mins Night_Mins Intl_Mins;
quit;
