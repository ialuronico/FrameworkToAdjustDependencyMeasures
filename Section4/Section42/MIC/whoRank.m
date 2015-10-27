close all;
clear all;
clc;

% Experiments in Section 4.2 of the paper
% Given each variable in the WHO dataset, we rank the top variables 
% according to different adjusted measures

% ATTENTION very slow to compute
% Change the number of S permutations for MIC
S = 3; % More than 1 hour but completely unreliable, try at least S = 1000

load('WHOdataFormatted.mat');
tic; 

[n, m] = size(WHO);

Meas = zeros(m,m);
Pvalues = zeros(m,m);
sampleSize = zeros(m,m);
AMeas = zeros(m,m);
SMeas = zeros(m,m);

alphas = [0.05 0.1 0.4 .5];
AMeasAlpha = zeros(m,m,length(alphas));

% Minimum sample size (discard relationships on smaller samples size)
minn = 10;

parfor j=4:m
  disp(j)
  for jp = 4:m
    missing = isnan(WHO(:,j)) | isnan(WHO(:,jp));
    X = WHO(~missing,j);
    Y = WHO(~missing,jp);
    notMiss = sum(~missing);
    if (notMiss >= minn && j ~= jp) % not the same variable
      
      % Raw measure
      minestats = mine(X',Y');
      meas = minestats.mic;
      pval = 0; % not computed here
      Pvalues(j,jp) = 1 - pval;      
      Meas(j,jp) = meas;
      sampleSize(j,jp) = notMiss;      
      
      % Adjusted for Quantificaiton
      AMeas(j,jp) = AMIC(X',Y',S);
      
      % Standardized for Ranking
      SMeas(j,jp) = SMIC(X',Y',S);
      
      % Adjustment for Ranking
      MeasAlphaV = zeros(1,length(alphas));
      for ai=1:length(alphas);
          a = alphas(ai);
          MeasAlphaV(ai) = AMIC_alpha(X',Y',a,S);
      end
      AMeasAlpha(j,jp,:) = MeasAlphaV;
    end
  end
end

% Ranking
sampleSizeMeas = zeros(m,m);
[bestMeas, bestIndMeas] = sort(Meas,2,'descend');
for j=4:m
  sampleSizeMeas(j,:) = sampleSize(j,bestIndMeas(j,:));
end

sampleSizePval = zeros(m,m);
[bestPval, bestIndPval] = sort(Pvalues,2,'descend');
for j=4:m
  sampleSizePval(j,:) = sampleSize(j,bestIndPval(j,:));
end

sampleSizeAMeas = zeros(m,m);
[bestAMeas, bestIndAMeas] = sort(AMeas,2,'descend');
for j=4:m
  sampleSizeAMeas(j,:) = sampleSize(j,bestIndAMeas(j,:));
end

sampleSizeSMeas = zeros(m,m);
[bestSMeas, bestIndSMeas] = sort(SMeas,2,'descend');
for j=4:m
  sampleSizeSMeas(j,:) = sampleSize(j,bestIndSMeas(j,:));
end

sampleSizeAMeasAlphas = zeros(m,m,length(alphas));
bestAMeasAlpha = zeros(m,m,length(alphas));
bestIndAMeasAlpha = zeros(m,m,length(alphas));
% different alpha
for ai=1:length(alphas);
    [bestAMeasAlpha(:,:,ai), bestIndAMeasAlpha(:,:,ai)] = sort(AMeasAlpha(:,:,ai),2,'descend');
    for j=4:m
        sampleSizeAMeasAlphas(j,:,ai) = sampleSize(j,bestIndAMeasAlpha(j,:,ai));
    end
end

toc;

save('WhoDatasetMIC');
disp('Results saved.');
