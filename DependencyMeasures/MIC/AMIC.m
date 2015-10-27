% Fuction to compute the Maximal Information Coefficient 
% adjusted for Quantification as per Equation 3.4

% Input 
% S - number of permutations
% MICalpha, c - refer to MIC documentation


function AMIC_ = AMIC(x, y, S, MICalpha, c)


switch nargin
    case 4
        c = 15;
    case 3
	c = 15;
        MICalpha = 0.6;
    case 2
        c = 15;
        MICalpha = 0.6;
        S = 30;
end


micperm = zeros(1,S);

for s=1:S
  x_perm = x(randperm( length(x) ));
  y_perm = y(randperm( length(y) ));
  minestats = mine_mex(x_perm, y_perm, MICalpha, c);
  micperm(s) = minestats(1);
end

% compute MIC
minestats = mine_mex(x, y, MICalpha, c);
MIC_ = minestats(1);

AMIC_ = (MIC_ - mean(micperm))./(1 - mean(micperm));






