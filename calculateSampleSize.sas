
%macro calculateSampleSize();
data &dset;
  set _temp;
  alpha=&alpha;
  alpha_comp=&alpha_comp;
  beta=1-power;
  zAlpha=-probit((alpha/(alpha_comp*2)));
  zBeta=-probit(beta);
  a=(zAlpha+zBeta)**2;
  b=(_p0*(1-_p0))/n;
  c=(_p1*(1-_p1))/n;
  d=(k**2)*((_p0**2)+(_p1**2));
  e=(_p0-_p1)**2;
  f=1+((a*(b+c+d))/e);
  clusters=1+ceil((a*(b+c+d))/e);
run;
%mend;
