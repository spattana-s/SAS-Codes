libname sas_data "C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data" 
access=read;
run;

proc copy in=sas_data out=work;
select lung;
run;

proc sort data=lung;
by height_father;
run;

**plot the raw data */statistical graphic***;

proc sgplot data=lung;
scatter x=height_father y=FEV1_father;
ellipse x=Height_father y=FEV1_father;
run;

**Box plot- to check**;
proc sgplot data=lung;
hbox Height_father / category=area;
*hbox FEV1_father /category=area;*;
run;

proc univariate data=lung normaltest plot;
var Height_father FEV1_father;
probplot Height_father / normal (mu=est sigma=est);**forward slash / means default **;
inset mean std / format=6.4;
run;

proc sgplot data=lung;
histogram FEV1_father/ ;
density FEV1_father/ ;
density FEV1_father/type=kernel ;
*xaxis values=(20 to 80 by 10);
run;

proc corr data=dsn cov;
var var1 var2 ....;
*partial var1 var2 ...;
run;

proc corr data=lung cov;
var FEV1_father Height_father;
run;

proc reg data=  outest= ;
     model         /   dwProb   ;
      OUTPUT OUT=   PREDICTED=    RESIDUAL=   L95M=c_l95m  U95M=C_u95m  L95=C_l95 U95=C_u95
       rstudent=  h=lev cookd=Cookd  dffits= 
     STDP=   STDR=   STUDENT=      ;  
     
  quit;

proc reg data=lung outest=est;
model FEV1_father= Height_father;
run;


proc reg data=lung  outest=est ;
     model      FEV1_father= Height_father   /   dwProb   ;
      OUTPUT OUT=reg_lungoUT   PREDICTED=    RESIDUAL=Res   L95M=l_l95m  U95M=l_u95m  L95=l_l95 U95=l_u95;
       rstudent=l_rstudent  h=lev cookd=Cookd  dffits=dffit 
     STDP=l_spredicted   STDR=l s__rsidual   STUDENT=l_student      ;  
	 plot FEV1_father*Height_father='*';
  quit;

  proc reg data=lung  outest=est ;
     model      FEV1_father= Height_father   /   dwProb   ;
      OUTPUT OUT=reg_lungoUT   PREDICTED=    RESIDUAL=Res   L95M=l_l95m  U95M=l_u95m  L95=l_l95 U95=l_u95;
       rstudent=l_rstudent  h=lev cookd=Cookd  dffits=dffit 
     STDP=l_spredicted   STDR=l_s_rsidual   STUDENT=l_student      ;  
	 plot FEV1_father* Height_father='*';
  quit;

  proc reg data=lung outest=est;
model FEV1_father= Height_father;
OUTPUT OUT=reg_lungoUT h=lev cookd=Cookd  dffits=dffit;
run;

 proc reg data=lung outest=est;
model FEV1_father= Height_father Age_father;
OUTPUT OUT=reg_lungoUT h=lev cookd=Cookd  dffits=dffit;
run;

*mother*/;

proc sgplot data=lung;
scatter x=height_mother y=FEV1_mother;
ellipse x=Height_mother y=FEV1_mother;
run;

**Box plot- to check**;
proc sgplot data=lung;
hbox Height_mother / category=area;
*hbox FEV1_father /category=area;*;
run;

proc univariate data=lung normaltest plot;
var Height_mother FEV1_mother;
probplot Height_mother / normal (mu=est sigma=est);**forward slash / means default **;
inset mean std / format=6.4;
run;

proc sgplot data=lung;
histogram FEV1_mother/ ;
density FEV1_mother/ ;
density FEV1_mother/type=kernel ;
*xaxis values=(20 to 80 by 10);
run;

proc corr data=dsn cov;
var var1 var2 ....;
*partial var1 var2 ...;
run;

proc corr data=lung cov;
var FEV1_mother Height_mother;
run;

proc reg data=  outest= ;
     model         /   dwProb   ;
      OUTPUT OUT=   PREDICTED=    RESIDUAL=   L95M=c_l95m  U95M=C_u95m  L95=C_l95 U95=C_u95
       rstudent=  h=lev cookd=Cookd  dffits= 
     STDP=   STDR=   STUDENT=      ;  
     
  quit;

proc reg data=lung outest=est;
model FEV1_mother= Height_mother;
run;


proc reg data=lung  outest=est ;
     model      FEV1_mother= Height_mother   /   dwProb   ;
      OUTPUT OUT=reg_lungoUT   PREDICTED=    RESIDUAL=Res   L95M=l_l95m  U95M=l_u95m  L95=l_l95 U95=l_u95;
       rstudent=l_rstudent  h=lev cookd=Cookd  dffits=dffit 
     STDP=l_spredicted   STDR=l_s_rsidual   STUDENT=l_student      ;  
	 plot FEV1_mother* Height_mother='*';
  quit;

  proc reg data=lung outest=est;
model FEV1_mother= Height_mother;
OUTPUT OUT=reg_lungoUT h=lev cookd=Cookd  dffits=dffit;
run;

 proc reg data=lung outest=est;
model FEV1_mother= Height_mother Age_mother;
OUTPUT OUT=reg_lungoUT h=lev cookd=Cookd  dffits=dffit;
run;

proc reg data=lung outest=est;
model FEV1_mother= Height_mother Age_mother Weight_mother;
OUTPUT OUT=reg_lungoUT h=lev cookd=Cookd  dffits=dffit;
run;


proc reg data=lung outest=est;
model FEV1_mother= Age_mother Weight_mother;
OUTPUT OUT=reg_lungoUT h=lev cookd=Cookd  dffits=dffit;
run;


proc corr data=lung cov;
var FEV1_mother Height_mother Weight_mother;
run;
