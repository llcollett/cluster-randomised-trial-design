
%include "P:\LSTM\Projects\TEEN TB\Code\calculatePower.sas";
%include "P:\LSTM\Projects\TEEN TB\Code\calculateSampleSize.sas";
%include "P:\LSTM\Projects\TEEN TB\Code\deleteW.sas";
%macro clusterTrialSampleSize(dset=,
/*type 1 error rate*/         alpha=,
/*number of comparisons*/       alpha_comp=,
/*power*/                     power=,
/*parameters to adapt*/         power_l=,power_u=,power_inc=,
/*prevalence control*/        p0=,
/*prevalence experimental*/   p1=,
/*parameters to adapt*/         p1_l=,p1_u=,p1_inc=,
/*cluster size*/              n=,
/*parameters to adapt*/         n_l=,n_u=,n_inc=,
/*ICC*/                       k=,
/*parameters to adapt*/         k_l=,k_u=,k_inc=,
/*number of clusters*/        clusters=,
/*parameters to adapt*/         clusters_l=,clusters_u=,clusters_inc=,
/*variable to adapt*/         adapt=,
/*variable to calculate*/     calculate=);

/*option list for ease of use*/
/*%clusterTrialSampleSize(dset=,alpha=,alpha_comp=,power=,power_l=,power_u=,power_inc=,p0=,p1=,
p1_l=,p1_u=,p1_inc=,n=,n_l=,n_u=,n_inc=,k=,k_l=,k_u=,k_inc=,
clusters=,clusters_l=,clusters_u=,clusters_inc=,adapt=,calculate=)*/

/*errors*/
%let calculateError=FALSE;
%if &calculate= %then %do;
  %put WARNING: You have not specified whether you want to calculate the sample size or the power.;
  %let calculateError=TRUE;
%end;
%let alphaError=FALSE;
%if &alpha= or &alpha_comp= %then %do;
  %put WARNING: You have not specified an alpha value or the number of comparisons that will occur.;
  %let alphaError=TRUE;
%end;
%let adaptssError=FALSE;
%let adaptclustersError=FALSE;
%if &adapt= %then %do;
  %if &calculate=ss %then %do;
    %if &power= or &p0= or &p1= or &n= or &k= %then %do;
      %put WARNING: You have not specified to adapt a variable, but you have not included inputs for all variables.;
	  %let adaptssError=TRUE;
	%end;
  %end;
  %else %if &calculate=power %then %do;
    %if &p0= or &p1= or &n= or &k= or &clusters= %then %do;
      %put WARNING: You have not specified to adapt a variable, but you have not included inputs for all variables.;
	  %let adaptclustersError=TRUE;
	%end;
  %end;
%end;
/*any of the errors are TRUE then terminate code*/
%if &calculateError=TRUE or &alphaError=TRUE or &adaptssError=TRUE or &adaptclustersError=TRUE %then %goto exit;

/*adaptions*/
data _temp;
/*no adaptions to occur*/
%if &adapt= %then %do;
  %let _p0=&p0/1000;
  %let _p1=&p1/1000;
  _p0=&_p0; _p1=&_p1; n=&n; k=&k;
%end;
/*adapting p1*/
%else %if &adapt=p1 %then %do;
  %if &p1~= %then %put WARNING: You have specified a level of p1 but would like this to adapt. Specified level of p1 has been ignored.;
  %if &p1_l= or &p1_u= or &p1_inc= %then %do;
    %put WARNING: You have specified to adapt p1, but have not specified the lower, upper or incremental values.;
	%goto exit;
  %end;
  %let _p0=&p0/1000;
  %let _p1_l=&p1_l/1000;
  %let _p1_u=&p1_u/1000;
  %let _p1_inc=&p1_inc/1000;
  do _p1=&_p1_l to &_p1_u by &_p1_inc;
    _p0=&_p0; n=&n; k=&k;
	output;
  end;
%end;
/*adapting n*/
%else %if &adapt=n %then %do;
  %if &n~= %then %put WARNING: You have specified a level of n, but you have also specified you would like this to adapt. Specified level of n has been ignored.;
  %if &n_l= or &n_u= or &n_inc= %then %do;
    %put WARNING: You have specified to adapt n, but have not specified the lower, upper or incremental values.;
	%goto exit;
  %end;
  %let _p0=&p0/1000;
  %let _p1=&p1/1000;
  do n=&n_l to &n_u by &n_inc;
    _p0=&_p0; _p1=&_p1; k=&k;
	output;
  end;
%end;
/*adapting k*/
%else %if &adapt=k %then %do;
  %if &k~= %then %put WARNING: You have specified a level of k, but you have also specified you would like this to adapt. Specified level of k has been ignored.;
  %if &k_l= or &k_u= or &k_inc= %then %do;
    %put WARNING: You have specified to adapt k, but have not specified the lower, upper or incremental values.;
	%goto exit;
  %end;
  %let _p0=&p0/1000;
  %let _p1=&p1/1000;
  do k=&k_l to &k_u by &k_inc;
    _p0=&_p0; _p1=&_p1; n=&n;
	output;
  end;
%end;
run;

/*to calculate the sample size*/
%if &calculate=ss %then %do;
  /*adapting power*/
  %if &adapt=power %then %do;
    %if &power~= %then %put WARNING: You have specified a level of power, but you have also specified you would like this to adapt. Specified level of power has been ignored.;
    %if &power_l= or &power_u= or &power_inc= %then %do;
      %put WARNING: You have specified to adapt power, but have not specified the lower, upper or incremental values.;
	  %goto exit;
    %end;
    %let _p0=&p0/1000;
    %let _p1=&p1/1000;
    data _temp;
      do power=&power_l to &power_u by &power_inc;
        _p0=&_p0; _p1=&_p1; n=&n; k=&k;
	    output;
      end;
    run;
    %calculateSampleSize();
  %end;
  %else %do;
    data _temp; set _temp;
	  power=&power;
	run;
    %calculateSampleSize();
  %end;
%end;

/*to calculate the power*/
%else %if &calculate=power %then %do;
  /*adapting sample size*/
  %if &adapt=clusters %then %do;
    %if &clusters~= %then %put WARNING: You have specified a level of clusters, but you have also specified you would like this to adapt. Specified level of clusters has been ignored.;
    %if &clusters_l= or &clusters_u= or &clusters_inc= %then %do;
      %put WARNING: You have specified to adapt clusters, but have not specified the lower, upper or incremental values.;
	  %goto exit;
    %end;
    %let _p0=&p0/1000;
    %let _p1=&p1/1000;
    data _temp;
      do clusters=&clusters_l to &clusters_u by &clusters_inc;
        _p0=&_p0; _p1=&_p1; n=&n; k=&k;
        output;
      end;
    run;
    %calculatePower();
  %end;
  %else %do;
    data _temp; set _temp;
	  clusters=&clusters;
	run;
    %calculatePower();
  %end;
%end;
%exit:
run;
/*deletes unnecesary datasets*/
%deleteW(dset=_temp);
%mend clusterTrialSampleSize;
