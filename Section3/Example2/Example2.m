clear all;
close all;
clc;

% This script analyses the amount of selection bias with Gini gain

% Number of Simulations
samples = 10000;

% Simulate variables with different number of categories
rs = [2:3];

n = 100; % Number of records
c = 2; % Number of classes

% alpha for AGini(alpha) (this is just a test)
alpha = 0.2;

% support variables
GiniGainfreq = zeros(1,length(rs));
AGiniGainfreq = zeros(1,length(rs));
SGiniGainfreq = zeros(1,length(rs));

% support variables for Par For
Ginivec = [];
AGinivec = [];
SGinivec = [];
parfor s=1:samples
    disp(['sample ' num2str(s)]);          
    scores = zeros(3,length(rs)); % collects the values 
        
    % Generate Class
    Y = zeros(1,n);        
    for j=1:n
        Y(j) = randi(c);
    end            
    
    for k=1:length(rs)
        r = rs(k); 
        % Generate variables with r categories
        X = zeros(1,n);        
        for j=1:n
            X(j) = randi(r);
        end    
        
        % Generate the contingency table
        T = Contingency(X,Y);
        %disp(T);
        
        % Compute
        scores(1,k) = Gini(T);         
        scores(2,k) = AGini_alpha(T,alpha); 
        scores(3,k) = SGini(T);         
    end

    % Compute which variable gets the highest score for each measure
    [~, win] = max(scores');
    
    Ginivec =  [Ginivec win(1)];
    AGinivec = [AGinivec win(2)];
    SGinivec = [SGinivec win(3)];
end

% Compute the frequencies of selection

for u=Ginivec
    GiniGainfreq(u) = GiniGainfreq(u) + 1;
end
for u=AGinivec
    AGiniGainfreq(u) = AGiniGainfreq(u) + 1;
end
for u=SGinivec
    SGiniGainfreq(u) = SGiniGainfreq(u) + 1;
end

h = figure;


subplot(3,1,1);
bar(rs,SGiniGainfreq'/sum(SGiniGainfreq),'r')
hold on;
plot(rs,SGiniGainfreq/sum(SGiniGainfreq),'ko--');
grid on;
ylabel('SGini','Interpreter','Latex');
title('Probability of Selection','Interpreter','latex');

subplot(3,1,2);
bar(rs,AGiniGainfreq'/sum(AGiniGainfreq),'w')
hold on;
plot(rs,AGiniGainfreq/sum(AGiniGainfreq),'k*--');
grid on;
ylabel(['AGini$(\alpha = ' num2str(alpha) ')$'],'Interpreter','Latex');

subplot(3,1,3);
bar(rs,GiniGainfreq'/sum(GiniGainfreq),'g')
hold on;
plot(rs,GiniGainfreq/sum(GiniGainfreq),'ks--');
grid on;
ylabel('Gini','Interpreter','Latex');
xlabel('Number of categories $r$','Interpreter','Latex');

set(h, 'Position', [150 150 420 340])
set(h,'PaperSize',[11.2 9],'PaperPositionMode','auto');
saveas(h,'Example2','pdf');

% Rusult added on the paper:
disp('Result on Example 2:');
disp(GiniGainfreq/sum(GiniGainfreq)*100)