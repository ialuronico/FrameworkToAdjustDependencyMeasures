close all;
clear all;
clc;

load('WhoDatasetR2');

% parameters

maxplot = 20;

% get rid of zeros
bestMeas(bestMeas == 0) = NaN;
bestAMeas(bestAMeas == 0) = NaN;
bestSMeas(bestSMeas == 0) = NaN;
bestPval(bestPval == 0) = NaN;
bestAMeasAlpha(bestAMeasAlpha == 0) = NaN;

sampleSizeMeas(isnan(bestMeas)) = NaN;
disp('Mean D');
disp(num2str(nanmean(sampleSizeMeas(:,1)),4));

sampleSizeAMeas(isnan(bestAMeas)) = NaN;
disp('Mean AD');
disp(num2str(nanmean(sampleSizeAMeas(:,1)),4));

sampleSizeSMeas(isnan(bestSMeas)) = NaN;
disp('Mean SD');
disp(num2str(nanmean(sampleSizeSMeas(:,1)),4));

for ai=1:length(alphas);
    thisSampleAlpha = sampleSizeAMeasAlphas(:,:,ai);
    thisMeasAlpha = bestAMeasAlpha(:,:,ai);
    thisSampleAlpha(isnan(thisMeasAlpha)) = NaN;
 
    disp([' Mean AD alpha = ' num2str(alphas(ai)) ]);
    disp(num2str(nanmean(thisSampleAlpha(:,1)),4));
end
