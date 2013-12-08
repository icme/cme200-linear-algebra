function [yhat] = mypolyval(x, beta)
% Takes a collection of x values and betas definining a
% polynomial and calculates 
% yi=P(xi)=beta0+beta1 xi+...+betan xi?n

% Turn inputs into column vectors
mybeta = beta(:); 
myx = x ( : ) ;

n = size(mybeta,1)-1; % order of polynomial

p=size(myx,1); %number of x points 

% Construct the data matrix
X= repmat(myx,[1,n+1]).^kron(ones(p,1), 0:n); 

yhat = X*mybeta;

end
