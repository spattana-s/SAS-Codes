/*
COOKD= Cook’s  influence statistic
COVRATIO=standard influence of observation on covariance of betas
DFFITS=standard influence of observation on predicted value
H=leverage, 
LCL=lower bound of a % confidence interval for an individual prediction. 
This includes the variance of the error, as well as the variance of the parameter estimates.
LCLM=lower bound of a % confidence interval for the expected value (mean) of the dependent variable
PREDICTED | P= predicted values
RESIDUAL | R= residuals, calculated as ACTUAL minus PREDICTED
RSTUDENT=a studentized residual with the current observation deleted
STDI=standard error of the individual predicted value
STDP= standard error of the mean predicted value
STDR=standard error of the residual
STUDENT=studentized residuals, which are the residuals divided by their standard errors
UCL= upper bound of a % confidence interval for an individual prediction
UCLM= upper bound of a % confidence interval for the expected value (mean) of the dependent variable
* Cook’s  statistic lies above the horizontal reference line at value 4/n *; 
* DFFITS’ statistic is greater in magnitude than 2sqrt(n/p);
* Durbin watson around 2 *;
* VIF over 10 multicolinear **;


*/


proc corr data= dsn cov;
  var   var1 var2 ..... ;
  *partial  var1 var2 .... ;
run;
title " Simple Regression for the cereal dataset rating vs. sugars";
proc reg data=  outest= ;
     model         /   dwProb   ;
      OUTPUT OUT=   PREDICTED=    RESIDUAL=   L95M=c_l95m  U95M=C_u95m  L95=C_l95 U95=C_u95
       rstudent=  h=lev cookd=Cookd  dffits= 
     STDP=   STDR=   STUDENT=      ;  
     
  quit;

 
