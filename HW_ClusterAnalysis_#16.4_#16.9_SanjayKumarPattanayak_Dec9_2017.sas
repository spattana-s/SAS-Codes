/*Problem Cluster Analysis #16.4, #16.9*/
ods pdf
file='C:\Users\sanja\Desktop\SAS_KashaDehnad\SAS_data\HW_Cluster Analysis_SanjayKPattanayak_#16.4, #16.9.pdf';
title "Cluster Analysis_Hierarchical and K-means clustering with K = 2 Problem 16.4";

libname assign "C:\Users\sanja\Desktop\SAS_KashaDehnad\SAS_data";
run;


data clusteranalysis;
input Cases X1 X2;
datalines;
1 11 10
2 8 10
3 9 11
4 5 4
5 3 4
6 8 5
7 11 11
8 10 12
;
run;

title "Scatter plot for visually estimating the no. of clusters required Problem 16.4";

proc sgplot data=clusteranalysis;
scatter x=X1 y=X2;
run;


title "The CLUSTER Procedure-Centroid Hierarchical Cluster Analysis Problem 16.4";

Proc cluster data=clusteranalysis outtree=clusteranalysistree noeigen nonorm method=centroid rsquare;
id cases;
var X1 X2;
run;
quit;

title "The TREE Procedure-Centroid Hierarchical Cluster Analysis Problem 16.4";

proc tree data=clusteranalysistree out=clusteranalysisout nclusters=2;
id cases;
copy X1 X2;
run;
quit;


proc sort data=clusteranalysisout;
by cluster;
run;

title "Cluster distribution-Hierarchical Cluster Analysis Problem 16.4";

proc print data=clusteranalysisout;
by cluster;
var cases X1 X2;
run;
quit;

Title "Scatter plot showing clusters formed by heirarchical method Problem 16.4";

proc sgplot data=clusteranalysisout;
scatter y=X2 x=X1/group=cluster;
run;
quit;


Title "Clustering using K-means - proc fastclus Problem 16.4";
proc fastclus data=clusteranalysis maxclusters=2 maxiter=100 list out=clusterKmeans;
id cases;
var X1 X2;
run;


Title "Plotting the clusters formed by K-means method Problem 16.4";
proc sgplot data=clusterKmeans;
scatter y=X2 x=X1/group=cluster;
run;
quit;

Title "Cluster Distribution - K-means method Problem 16.4";

proc sort data=clusterKmeans;
by cluster;
run;

proc print data=clusterKmeans;
by cluster;
var cases X1 X2;
run;
quit;

/**** Question 16.9 ****/

title "Cluster Analysis_data set from the family lung function data_Problem 16.9";


libname sas_data "C:\Users\sanja\Desktop\SAS_KashaDehnad\SAS_data" 
access=read;
run;

proc copy in=sas_data out=work;
select lung;
run;



/*Creating the new data set lungcluster_Problem 16.9"*/

data lung_mother;
set lung (keep=age_mother height_mother weight_mother FVC_mother FEV1_mother);
Class=1;
run;

data lung_mother;
set lung_mother;
rename age_mother=age height_mother=height weight_mother=weight FVC_mother=FVC FEV1_mother=FEV1;
run;

data lung_father;
set lung (keep=age_father height_father weight_father FVC_father FEV1_father);
Class=2;
run;

data lung_father;
set lung_father;
rename age_father=age height_father=height weight_father=weight FVC_father=FVC FEV1_father=FEV1;
run;

data lung_oldch;
set lung (keep=age_oldest_child height_oldest_child weight_oldest_child FVC_oldest_child FEV1_oldest_child);
Class=3;
run;

data lung_oldch;
set lung_oldch;
rename age_oldest_child=age height_oldest_child=height weight_oldest_child=weight FVC_oldest_child=FVC FEV1_oldest_child=FEV1;
run;

data lungcluster;
set lung_mother;
run;

proc append base=lungcluster data=lung_father;
run;

proc append base=lungcluster data=lung_oldch;
run;

proc standard data=lungcluster mean=0 std=1 out=lungcluster_standard;
var age height weight FVC FEV1;
run;


title "K-means clustering_First with 3 Clusters_Problem 16.9";

proc fastclus data=lungcluster_standard maxclusters=3 maxiter=100 list out=lungcluster_standard1;
id class;
var age height weight FVC FEV1;
run;

title 'Cluster Analysis for k=3 of Lung Function';

proc sgplot data = lungcluster_standard1;
vbar cluster / group = class;
run;

title "K-means clustering_Second with 2 Clusters_Problem 16.9";
proc fastclus data=lungcluster_standard maxclusters=2 maxiter=100 list out=lungcluster_standard2;
id class;
var age height weight FVC FEV1;
run;

title 'Cluster Analysis for k=2 of Lung Function';

proc sgplot data = lungcluster_standard2;
vbar cluster / group = class;
run;

ods pdf close;
