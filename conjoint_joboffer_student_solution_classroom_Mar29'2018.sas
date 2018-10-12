title ’Preference for job offers’;
data joboffer;
input Travel $ 1-4 Vacation $ 6-13   Rating ;
datalines;
Low	 3-weeks	9
High 3-weeks	8
Low	 2-weeks	6
High 2-weeks	5
;
run;

title2 "Metric Conjoint Analysis";
proc transreg data=joboffer utilities ;
model identity(rating)=class(Travel Vacation/ zero=sum);*Utilities add up to zero;
run; 


proc copy in = sas_data out = work;
select beer_sales;
run;

data beer_sales_b;
	set beer_sales;
	if week<=52;
	run;
proc sort data=beer_sales_b; by price_12pk;run;

proc sgplot data=beer_sales_b;
series x=Price_12PK y=cases_12pk;
run;

proc reg data=beer_sales_b;
model cases_12pk = price_12pk;
run;
quit;

data beer_sales_b;
	set beer_sales;
	if week<=52;
	*price_12pk_ln=log(price_12pk);
	run;

proc sgplot data=beer_sales_b;
series x=Price_12PK_ln y=cases_12pk_ln;
run;

proc reg data=beer_sales_b;
model cases_12pk_ln = price_12pk_ln;
run;
quit;
