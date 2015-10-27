clear all;
close all;
clc;

% load this for Ns and bands
load(['Saved/r2/typ1']);
AllMean = zeros(length(Ns),length(bands));

% Choose a measure to plot
whichMeas = 'r2'; % or Ar2
myTypes = [1];

% Choose a measure to plot
%whichMeas = 'MIC'; % ot AMIC
%myTypes = [1,2,3,4];


% Different relationship names
type_description={'Linear','Quadratic','Cubic','4th root'};


h = figure;
 for tu=1:length(myTypes);
    typ = myTypes(tu);
    load(['Saved/' whichMeas '/typ' num2str(typ)]);
    LegendM = cell(length(Ns),1);
    cc=hsv(length(Ns));
    subplot(2,3,tu);
    for k=1:length(Ns)      
      plot(bands/max(bands)*100,mean(MeasSaved(:,:,k)),'o-');
      hold all;
      n = Ns(k);
      LegendM{k,1} = ['$n$ = ' num2str(n)];
      % overall mean
      AllMean(k,:) = AllMean(k,:) + mean(MeasSaved(:,:,k));
      ylim([0 1]);
      grid on;
    end
    title(type_description{typ},'Interpreter','latex','FontSize',12);
    xlabel('Noise Level','Interpreter','latex','FontSize',12);
 end
legend(LegendM,'Interpreter','latex');
set(h, 'Position', [0 0 650 500])
set(h,'PaperSize',[18 25],'PaperPositionMode','auto');
saveas(h,['EquitabiltyForEachRelationship_' whichMeas],'pdf');


h2 = figure;
for k=1:length(Ns)      
      plot(bands/max(bands)*100,AllMean(k,:)/length(myTypes),'o-');%;,'color',cc(k,:));  
      hold all;
      n = Ns(k);
      LegendM{k,1} = ['$n$ = ' num2str(n)];
      %ylim([0 1]);
      grid on;
      xlabel('Noise Level','Interpreter','latex','FontSize',12);
      ylim([-.01 1]);
end

lll = legend(LegendM,'Interpreter','latex');
set(lll,'Location','best');
set(h2, 'Position', [0 0 280 280])
set(h2,'PaperSize',[8 8],'PaperPositionMode','auto');
saveas(h2,['EquitabiltyAverage_' whichMeas],'pdf');