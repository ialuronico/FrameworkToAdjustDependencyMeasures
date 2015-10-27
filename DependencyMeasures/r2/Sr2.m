% Compute the Standardized r^2 for ranking
% using Definition 4.1

function [Sr2_, pval] = Sr2(X,Y)
  [n,~] = size(X);

  [r, pval] = corr(X,Y);

  Er2 =  1/(n-1);
  var = 2*(n-2)/(n-1)/(n-1)/(n+1);
  Sr2_ = (r^2 - Er2)/sqrt(var);  
end
