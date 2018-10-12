*-------------------------------------------------------------------------;
* Project        :  Marketing Analytics                                         ;
* Developer(s)   :  Khasha Dehand                                         ;
* Comments       :  profile of income by zip code                         ;
*-------------------------------------------------------------------------;


proc copy in=sas_data out=work;
  select income_2015_nj_ny;
run;



proc format;
   value  agifmt
        1 = '$1 under $25,000       '
		2 = '$25,000 under $50,000  '
		3 = '$50,000 under $75,000  '
		4 = '$75,000 under $100,000 '
		5 = '$100,000 under $200,000'
		6 = '$200,000 or more       '        
       other='Unkown                '
       ;

run;



proc sort data=income_2015_nj_ny;by state zipcode;run;
data agi1 agi2 agi3 agi4 agi5 agi6 empty;
set  income_2015_nj_ny(rename=(n1=Returns));
     if AGI_STUB=1 then output  agi1;
else if AGI_STUB=2 then output  agi2;
else if AGI_STUB=3 then output  agi3;
else if AGI_STUB=4 then output  agi4;
else if AGI_STUB=5 then output  agi5;
else if AGI_STUB=6 then output  agi6;
else output empty;
run;


data agi_all;
  merge agi1(rename= (Returns=Returns1) drop=AGI_STUB) 
        agi2(rename= (Returns=Returns2) drop=AGI_STUB) 
        agi3(rename= (Returns=Returns3) drop=AGI_STUB)   
        agi4 (rename= (Returns=Returns4) drop=AGI_STUB) 
        agi5 (rename= (Returns=Returns5) drop=AGI_STUB) 
         agi6 (rename= (Returns=Returns6) drop=AGI_STUB)  ; 
  by STATEFIPS state zipcode;
run;
data zip_income_pct;
 set agi_all;
 
  array  Returns_pcts  {6}  Returns_pct1 -  Returns_pct6 ;
  array  Returns  Returns1 - Returns6   ;
  total=sum(of Returns1 - Returns6);
  do i=1 to 6;
     Returns_pcts[i]=round((Returns[i]/total)*100,.01);
  end;
run;



data zip_income_pct;
drop i;
 set agi_all;
 

  array  Returns_pcts  {6}  Returns_pct1 -  Returns_pct6 ;
  array  Returns  Returns1 - Returns6   ;
  total=sum(of Returns1 - Returns6);
  do i=1 to 6;
     Returns_pcts[i]=round((Returns[i]/total)*100,.01);
  end;
run;
