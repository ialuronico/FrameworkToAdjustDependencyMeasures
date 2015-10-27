% Compute the Adjustment for quantification for r^2
% using Equation 3.3

function [Ar2_, pval] = Ar2(X,Y)
  [n,~] = size(X);

  [r, pval] = corr(X,Y);

  Er2 =  1/(n-1);
  Ar2_ = (r^2 - Er2)/(1-Er2);  
end
