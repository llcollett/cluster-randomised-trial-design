
%macro deleteW(dset=);
proc datasets lib=work nolist;
  delete &dset;
run; 
quit;
%mend deleteW;
