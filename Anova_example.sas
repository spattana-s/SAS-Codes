
data sales;
infile datalines;
input channel $10. sales ;
datalines;
channel_1          5
channel_1          3
channel_1 	       10
channel_1 	       6
channel_2 	       10
channel_2	       15
channel_2	        8
channel_2	        7
channel_3 	       23
channel_3 	       18
channel_3 	       16
channel_3 	       11
;
run;

proc univariate;
var sales;
run;


proc anova data=sales;
      class channel;
      model sales =  channel;
   run;



