
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
  %let _p0=&p0/1000;
  %let _p1=&p1/1000;
  do n=&n_l to &n_u by &n_inc;
    _p0=&_p0; _p1=&_p1; k=&k;
	output;
  end;
%end;
/*adapting k*/
%else %if &adapt=k %then %do;
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
/*deletes unnecesary datasets*/
%deleteW(dset=_temp);
%mend clusterTrialSampleSize;
