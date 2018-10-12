
*Mother*/;

proc sgplot data=lung;
scatter x=height_mother y=FEV1_mother;
ellipse x=Height_mother y=FEV1_mother;
run;


proc sgplot data=lung;
hbox Height_mother / category=area;
run;

proc univariate data=lung normaltest plot;
var Height_mother FEV1_mother;
probplot Height_mother / normal (mu=est sigma=est);
inset mean std / format=6.4;
run;

proc sgplot data=lung;
histogram FEV1_mother/ ;
density FEV1_mother/ ;
density FEV1_mother/type=kernel ;
run;


proc corr data=lung cov;
var FEV1_mother Height_mother;
run;


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
