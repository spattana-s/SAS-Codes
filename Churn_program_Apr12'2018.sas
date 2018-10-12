proc copy in = Tmp1 out = work;
select churn;
run;

data churn2;
set churn;
if churn ="False." then V_churn=0;
else V_churn=1;
if VMail_Plan="yes" then V_voiceplan=1;
else V_voiceplan=0;
run;

proc freq data=churn2;
tables V_churn*V_voiceplan;
run;


proc logistic data=churn2 descending;
class V_voiceplan(ref='0') / param=ref;
model V_churn = V_voiceplan;
run;



data churn2;
set churn;
if churn ="False." then V_churn=0;
else V_churn=1;
if VMail_Plan="yes" then V_voiceplan=1;
else V_voiceplan=0;

if CustServ_Calls<2 then V_CSC=0;
else if CustServ_Calls<4 then V_CSC=1;
else V_CSC=2;

if CustServ_Calls<4 and CustServ_Calls>1 then V_CSCtemp1=1;
else V_CSCtemp1=0;
if CustServ_Calls>=4 then V_CSCtemp2=1;
else V_CSCtemp2=0;
run;


proc logistic data=churn2 descending;
class V_CSCtemp1(ref='0') V_CSCtemp2(ref='0') / param=ref;
model V_churn = V_CSCtemp1 V_CSCtemp2;
run;
quit;


proc logistic data=churn2 descending;
class V_CSC(ref='0') / param=ref;
model V_churn = V_CSC;
run;
quit;
