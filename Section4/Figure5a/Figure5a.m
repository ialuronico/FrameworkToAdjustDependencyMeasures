clear all;
close all;
clc;

% This script analyses the amount of selection bias with r^2
% When the population value \rho^2 = 0

% The same experiment can be run for MIC, AMIC, and SMIC
% (also note that the raw MIC has a stronger bias to small n than the 
%  raw r^2)

% Number of Simulations
samples = 1000;

% Simulate variables with different sample size
ns = [20 40 60 80 100];

% support variables
R2freq = zeros(1,length(ns));
AR2freq = zeros(1,length(ns));
SR2freq = zeros(1,length(ns));

% support variables for Par For
R2vec = [];
AR2vec = [];
SR2vec = [];
parfor s=1:samples
    disp(['sample ' num2str(s)]);          
    scores = zeros(3,length(ns)); % collects the values 
        
    for k=1:length(ns)
        n = ns(k); 
        X = zeros(1,n);        
        Y = zeros(1,n); 
        % Generate samples
        X = zeros(1,n);        
        for j=1:n
            X(j) = rand();
            Y(j) = rand();
        end    
        
        % Compute
        scores(1,k) = corr(X',Y')^2;
        %minestats = mine(X,Y);         
        %scores(1,k) = minestats.mic;
        scores(2,k) = Ar2(X',Y'); 
        %scores(2,k) = AMIC(X,Y); 
        scores(3,k) = Sr2(X',Y');         
        %scores(3,k) = SMIC(X,Y);         
    end

    % Compute which variable gets the highest score for each measure
    [~, win] = max(scores');
    
    R2vec =  [R2vec win(1)];
    AR2vec = [AR2vec win(2)];
    SR2vec = [SR2vec win(3)];
end

% Compute the frequencies of selection

for u=R2vec
    R2freq(u) = R2freq(u) + 1;
end
for u=AR2vec
    AR2freq(u) = AR2freq(u) + 1;
end
for u=SR2vec
    SR2freq(u) = SR2freq(u) + 1;
end

h = figure;


subplot(3,1,1);
bar(ns,SR2freq'/sum(SR2freq),'r')
hold on;
plot(ns,SR2freq/sum(SR2freq),'ko--');
grid on;
ylabel('S$r^2$','Interpreter','Latex');
title('Probability of Selection','Interpreter','latex');

subplot(3,1,2);
bar(ns,AR2freq'/sum(AR2freq),'c')
hold on;
plot(ns,AR2freq/sum(AR2freq),'kx--');
grid on;
ylabel('A$r^2$','Interpreter','Latex');

subplot(3,1,3);
bar(ns,R2freq'/sum(R2freq),'g')
hold on;
plot(ns,R2freq/sum(R2freq),'ks--');
grid on;
ylabel('$r^2$','Interpreter','Latex');
xlabel('Sample size $n$','Interpreter','Latex');

set(h, 'Position', [150 150 420 340])
set(h,'PaperSize',[11.2 9],'PaperPositionMode','auto');
saveas(h,'Figure5a','pdf');
