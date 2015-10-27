clear; 
close all;
clc;

% Generate Figure 1

whichMeas = 'r2';
% just the linear relationship
typ = 1;

% Load results with the Adjusted Measure
load(['Saved/A' whichMeas '/typ' num2str(typ)]);
AMeasSaved = MeasSaved;
% Load results with the raw measure
load(['Saved/' whichMeas '/typ' num2str(typ)]);

h3 = figure;

% different amount of white noise added 
% anyway white noise is added in percentages:
% bands/num.noise, e.g 3/30 = 10%
num.noise = 30;

% Choose the number of records
k = 3; %which number of records
totbands = 1:2:length(bands);
ind = 0;
for i=totbands
  band = bands(i);
  ind = ind + 1;
  subplot(1,length(totbands),ind);
  n = Ns(k);
  X = rand(1,n);
  Y = gen_fun_white(X,n,band,num,typ);
  plot(X,Y,'o','MarkerSize',5);
  xlabel([num2str(band/max(bands)*100,3) '\%'],'Interpreter','latex');
  set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
  set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', []);
  grid on;
  %X label
  x1 = ['$r^2 = ' num2str(mean(MeasSaved(:,i,k)),2) '$'];
  x2 = ['$\mbox{A}r^2 = ' num2str(mean(AMeasSaved(:,i,k)),2) '$'];
  xll = {x1,x2};
  %xlabel
  title(xll,'Interpreter','latex');
end

set(h3, 'Position', [200 200 1200 170])
set(h3,'PaperSize',[27 5.6],'PaperPositionMode','auto');
saveas(h3,['Fig1_Noise_' whichMeas],'pdf');