*-------------------------------------------------------------------------;
* Project        :  BIA652  Mulivariate Analysis                          ;
* Developer(s)   : Khasha Dehand                                          ;
* Comments       : Hclust                                                 ;
*-------------------------------------------------------------------------;


data Hpoints;
length point $8;
infile datalines;
input x;
Point='x_'||left(_n_);
datalines;
2
5
9
15
16
18
25
33
33
45
;
run;
proc cluster data = Hpoints outtree=Mytree method=SINGLE ;         
var x ;
id Point  ;run;

proc tree data = Mytree  ;
run;

proc tree noprint ncl=4 out=out;
   copy point;
run;
