close all;
clear all;
clc;

% Given a variable, it finds the top-ranked variable

load('WhoDatasetR2');

% Choose variable
j = 182;
% Chose which variables to show
top = 1;
% Which alpha level for the adjustment for ranking
ai = 2;


bestMeas(bestMeas == 0) = NaN;
bestAMeas(bestAMeas == 0) = NaN;
bestSMeas(bestSMeas == 0) = NaN;
bestPval(bestPval == 0) = NaN;
bestAMeasAlpha(bestAMeasAlpha == 0) = NaN;

h = figure;

% find lim for Y
maxY = max(WHO(:,j));
minY = min(WHO(:,j));

jp = bestIndMeas(j,top);
missing = isnan(WHO(:,j)) | isnan(WHO(:,jp));
X = WHO(~missing,jp);
Y = WHO(~missing,j);
notMiss = sum(~missing);
val = Meas(j,jp);
subplot(1,4,1);
plot(X,Y,'o');
% xtick
fst = 8;
fsl = 16;
set(gca, 'FontSize', fst)
grid on;

title(['$r^2$, $n = ' num2str(notMiss) '$'],'Interpreter','Latex','FontSize',fsl);
namey = strrep(names(j),'_',' ');
namey = strrep(namey, '%', '\%');
ylabel(filterName(namey{1}),'Interpreter','Latex','FontSize',fsl);
namex = strrep(names(jp),'_',' ');
namex = strrep(namex, '%', '\%');
xlabel(filterName(namex{1}),'Interpreter','Latex','FontSize',fsl);
ylim([minY maxY]);

jp = bestIndAMeas(j,top);
missing = isnan(WHO(:,j)) | isnan(WHO(:,jp));
X = WHO(~missing,jp);
Y = WHO(~missing,j);
notMiss = sum(~missing);
val = AMeas(j,jp);
subplot(1,4,2);
plot(X,Y,'o');
set(gca, 'FontSize', fst)
grid on;

title(['$\mbox{A}r^2$, $n = ' num2str(notMiss) '$'],'Interpreter','Latex','FontSize',fsl);
namex = strrep(names(jp),'_',' ');
namex = strrep(namex, '%', '\%');
xlabel(filterName(namex{1}),'Interpreter','Latex','FontSize',fsl);
ylim([minY maxY]);

jp = bestIndSMeas(j,top);
missing = isnan(WHO(:,j)) | isnan(WHO(:,jp));
X = WHO(~missing,jp);
Y = WHO(~missing,j);
notMiss = sum(~missing);
val = SMeas(j,jp);
subplot(1,4,3);
plot(X,Y,'o');
set(gca, 'FontSize', fst)
grid on;

title(['$\mbox{S}r^2$, $n = ' num2str(notMiss) '$'],'Interpreter','Latex','FontSize',fsl);
namex = strrep(names(jp),'_',' ');
namex = strrep(namex, '%', '\%');
xlabel(filterName(namex{1}),'Interpreter','Latex','FontSize',fsl);
ylim([minY maxY]);

a = alphas(ai);
jp = bestIndAMeasAlpha(j,top,ai);
missing = isnan(WHO(:,j)) | isnan(WHO(:,jp));
X = WHO(~missing,jp);
Y = WHO(~missing,j);
notMiss = sum(~missing);
val = AMeasAlpha(j,jp,ai);
subplot(1,4,4);
plot(X,Y,'o');
set(gca, 'FontSize', fst)
grid on;

title(['$\mbox{A}r^2( \alpha =' num2str(a) ')$, $n = ' num2str(notMiss) '$'],'Interpreter','Latex','FontSize',fsl);
namex = strrep(names(jp),'_',' ');
namex = strrep(namex, '%', '\%');
xlabel(filterName(namex{1}),'Interpreter','Latex','FontSize',fsl);
ylim([minY maxY]);

set(h, 'Position', [150 150 1600 300])
set(h,'PaperSize',[14 3.2],'PaperPositionMode','auto');
saveas(h,'Example_r2','pdf');

