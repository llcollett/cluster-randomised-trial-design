

%include "P:\LSTM\Projects\TEEN TB\clusterTrialSampleSize.sas";
%clusterTrialSampleSize(dset=samplesize,
                        alpha=0.05,alpha_comp=1,
                        power_l=0.6,power_u=0.9,power_inc=0.05,
                        p0=6.8,p1=4,
                        n=1400,
						k=0.15,
						adapt=power,
                        calculate=ss);
