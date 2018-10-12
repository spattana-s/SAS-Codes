proc copy in = sasdata out = work;
select cereal_ds;
run;

proc univariate data=cereal_ds normal;
var sugars;
run;

title "Simple regression model";

proc reg data=cereal_ds;
model rating = sugars;
run;
quit;



title "Multiple regression model";

proc reg data=cereal_ds;
model rating = sugars fiber / VIF stb;
run;
quit;


proc reg data=cereal_ds;
model rating = sugars fiber ;
run;
quit
