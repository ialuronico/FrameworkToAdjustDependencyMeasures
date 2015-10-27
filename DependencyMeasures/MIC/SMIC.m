% Fuction to compute the Maximal Information Coefficient 
% standardized for Ranking as per Definition 4.1

% Input 
% S - number of permutations
% MICalpha, c - refer to MIC documentation

function SMIC_ = SMIC(x, y, S, MICalpha, c)

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

SMIC_ = (MIC_ - mean(micperm))./sqrt(std(micperm));






