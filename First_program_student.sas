/****************************************************************** 
�  
�    
� First SAS program  
� Student Version   
�   
 ******************************************************************/


data stress;   
   infile datalines;   
   input Patient_ID $ 1-4 Name $ 6-25 RestHR 27-29 MaxHR 31-33 
         RecHR 35-37 TimeMin 39-40 TimeSec 42-43
         Tolerance $ 45;
	loaddt=today();	
 format loaddt date7. ;
 label Tolerance="comparison of stress test telorances";
 Datalines;
2458 Murray, W            72  185 128 12 38 D                                   
2462 Almers, C            68  171 133 10  5 I                                   
2501 Bonaventure, T       78  177 139 11 13 I                                   
2523 Johnson, R           69  162 114  9 42 S                                   
2539 LaMance, K           75  168 141 11 46 D                                   
2544 Jones, M             79  187 136 12 26 N                                   
2552 Reberson, P          69  158 139 15 41 D                                   
2555 King, E              70  167 122 13 13 I                                   
2563 Pitts, D             71  159 116 10 22 S                                   
2568 Eberhardt, S         72  182 122 16 49 N                                   
2571 Nunnelly, A          65  181 141 15  2 I                                   
2572 Oberon, M            74  177 138 12 11 D                                   
2574 Peterson, V          80  164 137 14  9 D                                   
2575 Quigley, M           74  152 Q13 11 26 I                                   
2578 Cameron, L           75  158 108 14 27 I                                   
2579 Underwood, K         72  165 127 13 19 S                                   
2584 Takahashi, Y         76  163 135 16  7 D                                   
2586 Derber, B            68  176 119 17 35 N                                   
2588 Ivan, H              70  182 126 15 41 N                                   
2589 Wilcox, E            78  189 138 14 57 I                                   
2595 Warren, C            77  170 136 12 10 S                                   
;
run;

data stress2;
	set stress;
	if RecHR=. then delete;
run;

data stress3;
	set stress;
	if RecHR=. then delete;
	total_sec = TimeMin*60 + TimeSec;
run;

data stress3;
	retain cum;
	set stress;
	if RecHR=. then delete;
	if _n_ = 1 then cum = 0;
	total_sec = TimeMin*60 + TimeSec;
	cum=cum+total_sec;
	output;
run;

data stress3;
	format cum comma10. ;
	set stress;
	if RecHR=. then delete;
	if _n_ = 1 then cum = 0;
	total_sec = TimeMin*60 + TimeSec;
	cum=cum+total_sec;
	retain cum;
run;


data stress3;
	
	set stress;
	if RecHR=. then delete;
	if _n_ = 1 then cum = 0;
	total_sec = TimeMin*60 + TimeSec;
	cum=cum+total_sec;
	format cum comma10. ;
	retain cum;
run;

data stress3;
	label cum = "Usage of our test faciltity";
	set stress;
	if RecHR=. then delete;
	if _n_ = 1 then cum = 0;
	total_sec = TimeMin*60 + TimeSec;
	cum=cum+total_sec;
	
	retain cum;
	format cum comma10. ;
run;

proc print data=stress2;
	var Patient_ID RecHR RestHR MaxHR;
run;


Title "This is the result of proc print"; * title are free floating;
proc print data=stress3;
	var Patient_ID RecHR RestHR MaxHR total_sec cum;
	sum total_sec;
run;

Title "This is the result of proc univariate";
proc univariate data=stress3;
	var RecHR RestHR MaxHR;
run;

data stress2;
put _all_;
total=TimeMin*60+TimeSec;
 put _all_;
  set stress;
 put _all_;
  output;
run;


