function gradLogi(theta)
g = @(x) 1/(1+exp(-x));
%y = arrayfun(g,x);
gradl = @(x,y,theta) (y - g(theta'*x))*x;

theta = [0;0];
m = length(y);
for i = 1:m
  gl = gl + gradl(x(i,:),y(i));
end

