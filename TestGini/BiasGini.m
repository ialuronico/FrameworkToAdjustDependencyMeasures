clear all;
close all;
clc;

samples = 500;

nval = [2:3]; % number a values for X_1 and X_2 respectively

n = 100; % Number of records
c = 2; % number of values for Y

freq = zeros(1,length(nval));

dispVal = zeros(samples,length(nval));

vec = [];

for s=1:samples
    disp(['sample ' num2str(s)]);          
    scores = zeros(1,length(nval)); 
        
    % Generate reference variable Y
    Y = zeros(1,n);        
    for j=1:n
        Y(j) = randi(c);
    end            
    
    for k=1:length(nval)
        % Generate X 
        X = zeros(1,n);        
        for j=1:n
            X(j) = randi(nval(k));
        end    
        
        T = Contingency(X,Y);
        %disp(T);
        
        % Compute Dependency measure
        scores(k) = Gini(T); 
        dispVal(s,k) = scores(k);
    end

    % Compute which variable gets the highest score
    [~, win] = max(scores);
    
    vec = [vec win];
end

% Compute the frequencies of selection

for u=vec
    freq(u) = freq(u) + 1;
end

h = figure;
bar(nval',freq'/samples,'g')
hold on;
plot(nval,freq/samples,'ks--');
grid on;
title('Probability of Selection','Interpreter','latex','FontSize',12);
set(0, 'defaultTextInterpreter', 'latex');
Dnames = {'$X_1$','$X_2$'};

set(gca,'XTickLabel',Dnames);
format_ticks(gca,' ');

set(h, 'Position', [150 150 220 255])
set(h,'PaperSize',[7 7],'PaperPositionMode','auto');
saveas(h,'biasGini','pdf');