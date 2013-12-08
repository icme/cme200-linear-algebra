function [ beta ] = mypolyfit (x , y , n)

% Fits an n-th order polynomial to pairs (x(i), y(i)) 
% Returns the coefficients beta 0 , beta 1 , ... , beta n 
% for P(x) = beta 0 + beta 1 x + ... + beta n x^n
% minimizing sum[ (y i - P(x i))^2 ]


% Turn inputs into column vectors
myx = x ( : ); 
myy = y ( : ) ;

K= size(myx,1);

% % One way to construct the data matrix % X = zeros(K, n+1);
%
% % Using for loops
%for p=0:n, 
%X(:,p+1)=myx .^p; 
% end


% Construct the data matrix
X= repmat(myx,[1,n+1]) .^ kron(ones(K,1), 0:n); 


% Return the least squares solution
beta = X \ myy; 
end
