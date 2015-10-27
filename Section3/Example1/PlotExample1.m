clear all;
close all;
clc;

% In order to run this script you have to run AdjustmentForQuantification.m
% first.

% Choose MIC measure
whichMeas = 'MIC';
load(['Saved/' whichMeas '/typ1']);

% This is according the code I ran
MIC20 = MeasSaved(:,11,1);
MIC80 = MeasSaved(:,11,4);

h = figure;

boxplot([MIC80 MIC20],'orientation','horizontal')
set(gca,'xgrid','on') 
Dnames = {'$\mbox{MIC}(\mathcal{S}_{80}|X,Y)$','$\mbox{MIC}(\mathcal{S}_{20}|X,Y)$'};
%set(gca,'fontsize',15)
format_ticks(gca,' ',Dnames);
grid minor;

set(h, 'Position', [200 200 780 150])
set(h,'PaperSize',[22 4.6],'PaperPositionMode','auto');
saveas(h,'Example1','pdf');