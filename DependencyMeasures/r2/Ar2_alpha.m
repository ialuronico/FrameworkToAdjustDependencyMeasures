% Compute the Adjustment for ranking for r^2
% using Definition 4.2 

function [Ar2alpha_, pval] = Ar2_alpha(X,Y, alpha)
  [n,~] = size(X);

  [r, pval] = corr(X,Y);

  % compute q(1-alpha)
  q = betainv(1 - alpha,0.5,0.5*(n-2)); 
  Ar2alpha_ = r^2 - q;
end
