
%include "P:\LSTM\Projects\TEEN TB\Code\clusterTrialSampleSize.sas";
%deleteW(dset=test:);


/*TESTS TO CALCULATE SAMPLE SIZE*/
%include "P:\LSTM\Projects\TEEN TB\Code\clusterTrialSampleSize.sas";
/*test 1: calculate sample size with specified power, no adaptions*/
%clusterTrialSampleSize(dset=test_ss1,
                        alpha=0.05,alpha_comp=1,
						power=0.8,
                        p0=6.8,p1=4,
                        n=1400,
						k=0.15,
                        calculate=ss);

%include "P:\LSTM\Projects\TEEN TB\Code\clusterTrialSampleSize.sas";
/*test 2: calculate sample size with 3 comparisons*/
%clusterTrialSampleSize(dset=test_ss2,
                        alpha=0.05,alpha_comp=3,
						power=0.8,
                        p0=6.8,p1=4,
                        n=1400,
						k=0.15,
                        calculate=ss);

%include "P:\LSTM\Projects\TEEN TB\Code\clusterTrialSampleSize.sas";
/*test 3: adapting power to calculate sample size*/
%clusterTrialSampleSize(dset=test_ss3,
                        alpha=0.05,alpha_comp=1,
                        power_l=0.6,power_u=0.9,power_inc=0.05,
                        p0=6.8,p1=4,
                        n=1400,
						k=0.15,
						adapt=power,
                        calculate=ss);

%include "P:\LSTM\Projects\TEEN TB\Code\clusterTrialSampleSize.sas";
/*test 4: adapting experimental prevalence to calculate sample size*/
%clusterTrialSampleSize(dset=test_ss4,
                        alpha=0.05,alpha_comp=1,
                        power=0.8,
                        p0=6.8,p1_l=3,p1_u=5,p1_inc=0.1,
                        n=1400,
						k=0.15,
						adapt=p1,
                        calculate=ss);

%include "P:\LSTM\Projects\TEEN TB\Code\clusterTrialSampleSize.sas";
/*test 5: adapting cluster size to calculate sample size*/
%clusterTrialSampleSize(dset=test_ss5,
                        alpha=0.05,alpha_comp=1,
                        power=0.8,
                        p0=6.8,p1=4,
                        n_l=100,n_u=2000,n_inc=100,
						k=0.15,
						adapt=n,
                        calculate=ss);

%include "P:\LSTM\Projects\TEEN TB\Code\clusterTrialSampleSize.sas";
/*test 6: adapting ICC to calculate sample size*/
%clusterTrialSampleSize(dset=test_ss6,
                        alpha=0.05,alpha_comp=1,
                        power=0.8,
                        p0=6.8,p1=4,
                        n=1400,
						k_l=0.01,k_u=0.25,k_inc=0.01,
						adapt=k,
                        calculate=ss);

/*TESTS TO CALCULATE POWER*/
%include "P:\LSTM\Projects\TEEN TB\Code\clusterTrialSampleSize.sas";
/*test 1: calculate power with specified sample size, no adaptions*/
%clusterTrialSampleSize(dset=test_power1,
                        alpha=0.05,alpha_comp=1,
                        p0=6.8,p1=4,
                        n=1400,
						k=0.15,
						clusters=10,
                        calculate=power);

%include "P:\LSTM\Projects\TEEN TB\Code\clusterTrialSampleSize.sas";
/*test 2: calculate power with 3 comparisons*/
%clusterTrialSampleSize(dset=test_power2,
                        alpha=0.05,alpha_comp=3,
                        p0=6.8,p1=4,
                        n=1400,
						k=0.15,
						clusters=10,
                        calculate=power);

%include "P:\LSTM\Projects\TEEN TB\Code\clusterTrialSampleSize.sas";
/*test 3: adapting cluster size to calculate power*/
%clusterTrialSampleSize(dset=test_power3,
                        alpha=0.05,alpha_comp=1,
                        p0=6.8,p1=4,
                        n=1400,
						k=0.15,
						clusters_l=2,clusters_u=30,clusters_inc=2,
                        adapt=clusters,
                        calculate=power);

%include "P:\LSTM\Projects\TEEN TB\Code\clusterTrialSampleSize.sas";
/*test 4: adapting experimental prevalence to calculate power*/
%clusterTrialSampleSize(dset=test_power4,
                        alpha=0.05,alpha_comp=1,
                        p0=6.8,p1_l=3,p1_u=5,p1_inc=0.1,
                        n=1400,
						k=0.15,
						clusters=10,
						adapt=p1,
                        calculate=power);

%include "P:\LSTM\Projects\TEEN TB\Code\clusterTrialSampleSize.sas";
/*test 5: adapting cluster size to calculate power*/
%clusterTrialSampleSize(dset=test_power5,
                        alpha=0.05,alpha_comp=1,
                        p0=6.8,p1=4,
                        n_l=100,n_u=2000,n_inc=100,
						k=0.15,
						clusters=10,
						adapt=n,
                        calculate=power);

%include "P:\LSTM\Projects\TEEN TB\Code\clusterTrialSampleSize.sas";
/*test 6: adapting ICC to calculate power*/
%clusterTrialSampleSize(dset=test_power6,
                        alpha=0.05,alpha_comp=1,
                        p0=6.8,p1=4,
                        n=1400,
						k_l=0.01,k_u=0.25,k_inc=0.01,
						clusters=10,
						adapt=k,
                        calculate=power);

/*TESTS TO THROW ERRORS*/
%include "P:\LSTM\Projects\TEEN TB\Code\clusterTrialSampleSize.sas";
/*test 1: not stating whether want to calculate sample size or power, not including alpha comparisons*/
%clusterTrialSampleSize(dset=test_error1,
                        alpha=0.05,
						power=0.8,
                        p0=6.8,p1=4,
                        n=1400);
%include "P:\LSTM\Projects\TEEN TB\Code\clusterTrialSampleSize.sas";
/*test 2: calculating sample size, not stated variable to adapt but not included all variable levels*/
%clusterTrialSampleSize(dset=test_error2,
                        alpha=0.05,alpha_comp=1,
						power=0.8,
                        p0=6.8,p1=4,
                        n=1400,
                        calculate=ss);
%include "P:\LSTM\Projects\TEEN TB\Code\clusterTrialSampleSize.sas";
/*test 3: calculating sample size, adapting power, not specified limits*/
%clusterTrialSampleSize(dset=test_error3,
                        alpha=0.05,alpha_comp=1,
						power=0.8,
                        p0=6.8,p1=4,
                        n=1400,
						k=0.15,
						adapt=power,
                        calculate=ss);


*%clusterTrialSampleSize(dset=,alpha=,alpha_comp=,power=,power_l=,power_u=,power_inc=,p0=,p1=,
p1_l=,p1_u=,p1_inc=,n=,n_l=,n_u=,n_inc=,k=,k_l=,k_u=,k_inc=,
clusters=,clusters_l=,clusters_u=,clusters_inc=,adapt=,calculate=);

options nomprint;
