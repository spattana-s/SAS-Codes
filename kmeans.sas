
*-------------------------------------------------------------------------;
* Project        :  BIA652  Mulivariate Analysis                          ;
* Developer(s)   : Khasha Dehand                                          ;
* Comments       : Kmeans clustering                                    ;
*-------------------------------------------------------------------------;

title1 " ";
Title2 "  ";

data kPoints;
infile datalines;
input Point $ d1 d2; 
datalines;
a   1   3
b   3   3
c   4   3
d   5   3
e   1   2
f   4   2
g   1   1
h   2   1
;
run;



goptions reset=all hsize = 6in vsize = 6in;
axis1 order=(0 to 6.0 by 0.5) minor = none;
axis2 order=(0 to 6.0 by 0.5) minor = none;
symbol1 i=line v=dot;
proc gplot data = kPoints ;
plot d1*d2 = point / vref = 0 vaxis = axis1 haxis=axis2 ;
run;
quit;

proc fastclus data =kPoints  
      maxclusters =2 out=KC_out; 
var d1 d2  ;
id  Point ;
run;
proc print data =KC_out;
var point cluster  ;
run;


data income_NJ;
	set zip_income_pct;
	if state='NJ';
run;


proc fastclus data =income_NJ  
      maxclusters =5 out=KC_NJ; 
var Returns_pct5 Returns_pct6  ;
id  zipcode ;
run;
