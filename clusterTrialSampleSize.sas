
%include "P:\LSTM\Projects\TEEN TB\calculatePower.sas";
%include "P:\LSTM\Projects\TEEN TB\calculateSampleSize.sas";
%include "P:\LSTM\Projects\TEEN TB\deleteW.sas";
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

/*translate prevalences back to proportions*/
%let _p0=&p0/1000;
%let _p1=&p1/1000;

/*to calculate the sample size*/
%if &calculate=ss %then %do;
  %calculateSampleSize();
%end;
/*to calculate the power*/
%else %if &calculate=power %then %do;
  %calculatePower();
%end;
/*deletes unnecesary datasets*/
%deleteW(dset=_temp);
%mend clusterTrialSampleSize;
