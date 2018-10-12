*import churn;
libname sas_data "C:\Users\sanja\Desktop\GMAT\STEVENS MSBA\1stSem\SAS_KashaDehnad\SAS_data";
*access=read;
run;
proc copy in=sas_data out=work;
select factor_test;
run;

proc princomp data=factor_test out=factor_test_out;
VAR section1 section2 section3;
run;


title "Factor Analysis";
title2 " ";
options pagesize 120;
proc factor data = factor_test print method = principal nfactors=2
				score scree residuals EIGENVECTORS PLOT
				MINEIGEN = 0 ROTATE=NONE
				outstat=fact out=factout;
VAR section1 section2 section3;
run;
