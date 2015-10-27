% Fuction to compute the Maximal Information Coefficient 
% adjusted for ranking 
% using Definition 4.2 

% Input 
% S - number of permutations
% alpha - parameter for adjustment
% MICalpha, c - refer to MIC documentation

function AMICalpha_ = AMIC_alpha(x, y, alpha, S, MICalpha, c)

switch nargin
    case 5
        c = 15;
    case 4
        c = 15;
        MICalpha = 0.6;
    case 3
        c = 15;
        MICalpha = 0.6;
        S = 30; % this default value is very small!!
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

SortedMIC0 = sort(micperm);
cutoff = ceil(S*(1-alpha));
q = SortedMIC0(cutoff);

AMICalpha_ = MIC_ - q;






