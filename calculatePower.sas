
%macro calculatePower();
data &dset;
  set _temp;
  alpha=&alpha;
  alpha_comp=&alpha_comp;
  a=clusters-1;
  b=(_p0*(1-_p0))/n;
  c=(_p1*(1-_p1))/n;
  d=(k**2)*((_p0**2)+(_p1**2));
  e=(_p0-_p1)**2;
  a1=(a*e)/(b+c+d);
  zAlpha=-probit((alpha/(alpha_comp*2)));
  b1=sqrt(a1)-zAlpha;
  power=probnorm(b1);
run;
%mend;
