dist = (0:5:40)';
temp = [2; 2.2; 5.8; 10.4; 11.0; 13.8; 22.4; 28.4; 33.3];

beta1 = mypolyfit ( dist , temp ,1);
beta2 = mypolyfit ( dist , temp , 2);

plot(dist, temp, 'k.'); 
hold on ;

x = linspace (0 ,40 ,100) ; 
plot(x, mypolyval(x, beta1) ,'g-') ;
plot(x, mypolyval(x, beta2) ,'b-');

legend('Given data','Linear fit ','Quadratic fit ', 'Location','NorthWest');

%%
% Create a function to compute the 2-norm of the residual as defined by n 
resid = @(n) norm(temp - mypolyval(dist , mypolyfit(dist , temp, n)));

% Compute this function for n = 0:8
error_n = arrayfun(resid , 0:8);

plot (0:8 , error_n ) ;
xlabel( ' Order of polynomial ' ) ; 
ylabel('Residual 2-norm');

%%
newdist = [45; 50]; 
newtemp = [48.9; 57.9];

% Create a function to compute the predicted values
predict = @(n) mypolyval ( newdist , mypolyfit ( dist , temp , n) ) ;

% Calculate the predicted values for varying n
predicted = zeros(2 ,9) ; 
for n = 0:8
	predicted(:,n+1) = predict(n);
end

% Create a function to compute the 2-norm of the predicted error
resid =@(n) norm(newtemp- mypolyval(newdist, mypolyfit(dist, temp, n)));

% Compute this function for n = 0:8
error_n = arrayfun(resid , 0:8)

alldist = [ dist ; newdist ]; 
alltemp = [temp; newtemp];

% Create a function to compute the 2-norm of the total error
resid = @(n) norm(alltemp-mypolyval(alldist , mypolyfit(dist , temp, n)));

% Compute this function for n = 0:8
error_n = arrayfun(resid , 0:8)
semilogy(0:8 , error_n ) ;
xlabel ( ' Order of polynomial ') ; 
ylabel('Total error residual 2-norm');