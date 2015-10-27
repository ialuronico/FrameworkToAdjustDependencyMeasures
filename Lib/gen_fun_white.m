% Function to generate different relationship types at different levels of
% white noise. 

% input:    x - random variable
%           n - number of points 
%           l - noise level
%           num - total number of noise levels
%           typ - relationship type to generate
% output:   y - random variable
%           name - relationship name

function [ y,name ] = gen_fun_white(x,n,l,num,typ)
    y=zeros(1,n);
    
    % Linear
    if typ==1
        y=x;
    end

    % Quadratic
    if typ==2
        y=4*(x-.5).^2;
    end

    % Cubic
    if typ==3
        y=128*(x-1/3).^3-48*(x-1/3).^3-12*(x-1/3);
    end

    % 4th Root
    if typ==4
        y=x.^(1/4);
    end

    % Add white noise 
    % substitute l/num.noise percent of points with random points
    howmany = floor(n*(0 + 1*l/num.noise));
    if(howmany > n)
        howmany = n;
    end
    min_y = min(y);
    max_y = max(y);
    y(randsample(n,howmany)') = min_y + (max_y - min_y)* rand(1,howmany);

    type_description={'Linear','Quadratic','Cubic','4th Root'};
    name = type_description{typ};
end

