
Title " Sample Size for A/B Testing";
proc power;
  twosamplefreq test=pchi
      proportiondiff =.006
	  refproportion =.03
	  npergroup=.
	  power =.90
	  alpha= .05;
run;


