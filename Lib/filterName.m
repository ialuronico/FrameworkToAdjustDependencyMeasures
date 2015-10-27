function [ filtered ] = filterName( name, whensplit)
  if (nargin < 2)
    whensplit = 6;
  end
  % some substitution
  name = strrep(name, '$', '\$');
  name = strrep(name, '&lt;', '$<$');
  name = strrep(name, '&gt;', '$>$');
  
  notFiltered = strsplit(name,' ');
  n = length(notFiltered);
  if (n < whensplit) % do nothing
    filtered = name;
    return;
  end
  half = ceil(n/2-1);  
  firsthalf = '';
  for i=1:half
    firsthalf = [firsthalf ' ' notFiltered{i}];
  end
  secondhalf = '';
  for i=half+1:n
    secondhalf = [secondhalf ' ' notFiltered{i}];
  end
  filtered = {firsthalf, secondhalf};
end

