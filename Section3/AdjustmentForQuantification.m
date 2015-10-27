% This code is related to the experiments in Section 3 of the paper

clear all;
close all;
clc;

tic;

% Choose one measure
% e.g. MIC AMIC r2 and Ar2
whichMeas = 'r2';

% maximum level of noise
num.noise = 30;
% different amount of white noise added 
% anyway white noise is added in percentages:
% bands/num.noise, e.g 3/30 = 10%
%
% This is useful to see the resolution of the plot
bands = (0:3:num.noise);

% Different types of relationships between X and Y
% linear, quadratic, cubic, and 4th root.
types = [1 2 3 4];

% Different sample size n
Ns = [20 40 60 80];

% How many simulations
samples = 1000;

for typ=types
    disp(typ);
    ToPlot = zeros(length(bands),length(Ns));
    for k=1:length(Ns)
      n = Ns(k);
      for i=1:length(bands)
        band = bands(i);
        disp([' n = ' num2str(n) ' and noise = ' num2str(band/num.noise*100) '%']);
        
        parfor s=1:samples
          X = rand(1,n); % uniform in [0,1]
          % White
          Y = gen_fun_white(X,n,band,num,typ);

          meas = 0;
          % MIC
          if (strcmp(whichMeas,'MIC'))
            minestats = mine(X,Y);
            meas = minestats.mic;
          end
          if (strcmp(whichMeas,'r2'))
            meas = corr(X',Y');
            meas = meas^2;
          end
          if (strcmp(whichMeas,'Ar2'))
            meas = Ar2(X',Y');
          end
          if (strcmp(whichMeas,'AMIC'))
            S = 10; % number of permutations
            meas = AMIC(X,Y,S);
          end         
          
          MeasSaved(s,i,k) = meas;

        end
      end
    end    
    save(['Saved/' whichMeas '/typ' num2str(typ)],'MeasSaved','Ns','bands','types');
end

toc;
disp('Done.');
    