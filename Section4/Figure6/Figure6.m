clear all;
close all;
clc;

% This script analyses the amount of selection bias with r^2
% When the population value \rho^2 > 0

% In this case we vary the adjustment for ranking Ar^2(alpha)
% varying the parameter alpha

% we get \rho^2 > 0 by fixing the amount of white noise
% l/num.noise, e.g 3/30 = 10%
l = 3;
num.noise = 30;

% The same experiment can be run for AMIC(alpha)
% (also note that the raw MIC has a stronger bias to small n than the 
%  raw r^2)

% Number of Simulations
samples = 10000;

% Simulate variables with different sample size
ns = [20 40 60 80 100];

% support variables
AR2a1freq = zeros(1,length(ns));
AR2a2freq = zeros(1,length(ns));
AR2a3freq = zeros(1,length(ns));

% support variables for Par For
AR2a1vec = [];
AR2a2vec = [];
AR2a3vec = [];
parfor s=1:samples
    disp(['sample ' num2str(s)]);          
    scores = zeros(3,length(ns)); % collects the values 
        
    for k=1:length(ns)
        n = ns(k); 
        % Generate samples
        X = rand(1,n);        
        Y = gen_fun_white(X,n,l,num,1); % linear relationship        
        % Compute
        scores(1,k) = Ar2_alpha(X',Y',0.05);
        %scores(1,k) = AMIC_alpha(X,Y,0.05);
        scores(2,k) = Ar2_alpha(X',Y',0.2); 
        %scores(2,k) = AMIC_alpha(X,Y,0.2); 
        scores(3,k) = Ar2_alpha(X',Y',0.4);         
        %scores(3,k) = AMIC_alpha(X,Y,0.4);         
    end

    % Compute which variable gets the highest score for each measure
    [~, win] = max(scores');
    
    AR2a1vec =  [AR2a1vec win(1)];
    AR2a2vec = [AR2a2vec win(2)];
    AR2a3vec = [AR2a3vec win(3)];
end

% Compute the frequencies of selection

for u=AR2a1vec
    AR2a1freq(u) = AR2a1freq(u) + 1;
end
for u=AR2a2vec
    AR2a2freq(u) = AR2a2freq(u) + 1;
end
for u=AR2a3vec
    AR2a3freq(u) = AR2a3freq(u) + 1;
end

h = figure;


subplot(3,1,1);
bar(ns,AR2a1freq'/sum(AR2a1freq),'w')
hold on;
plot(ns,AR2a1freq/sum(AR2a1freq),'k*--');
grid on;
ylabel('A$r^2(\alpha = 0.05)$','Interpreter','Latex');
title('Probability of Selection','Interpreter','latex');

subplot(3,1,2);
bar(ns,AR2a2freq'/sum(AR2a2freq),'w')
hold on;
plot(ns,AR2a2freq/sum(AR2a2freq),'k*--');
grid on;
ylabel('A$r^2(\alpha = 0.2)$','Interpreter','Latex');

subplot(3,1,3);
bar(ns,AR2a3freq'/sum(AR2a3freq),'w')
hold on;
plot(ns,AR2a3freq/sum(AR2a3freq),'k*--');
grid on;
ylabel('A$r^2(\alpha = 0.4)$','Interpreter','Latex');
xlabel('Sample size $n$','Interpreter','Latex');

set(h, 'Position', [150 150 420 340])
set(h,'PaperSize',[11.2 9],'PaperPositionMode','auto');
saveas(h,'Figure6','pdf');
