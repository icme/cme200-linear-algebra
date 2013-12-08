function part_f

%Exact solution
T = @(x) (-182/9*x)*(x<1/3) + ((-482*x+50)/9+50*x^2)*(x>=1/3);

x=0:0.01:1;
for k=1:length(x)
	t(k) = T(x(k));		%evaluate exact solution (for plotting)
end

f = @(x) 100*(x>1/3);

%compute finite difference solutions
[T5, x5] = heatEqnSolver1D(5, f);
[T10, x10] = heatEqnSolver1D(10, f);
[T25, x25] = heatEqnSolver1D(25, f);
[T200, x200] = heatEqnSolver1D(200, f);

%plot all solutions together
figure(1);
plot(x5 ,T5, x10, T10, x25, T25, x200, T200, x, t);
legend({'N=5', 'N=10', 'N=25', 'N=200', 'exact'}, 'Location', 'SouthWest');



T_all = {T5, T10, T25, T200};	% cell array with all FD solutions
N = [5, 10, 25, 200];			% number of points used in discretizations
norms_exct = zeros(1,length(N));
rel_errors = zeros(1,length(N));

%compute relative errors wrt 2-norms
for m = 1:length(N)
	h = 1/N(m);    % Interval size of discretization
	x = 0:h:1;
	t = zeros(N(m),1);	%initialize t (exact solution evaluated at N discrete locations)
	for k = 1:length(x)
		t(k) = T(x(k));
	end
	norms_exct(m) = norm(t);
	norms_exct_apprx(m) = norm(t - T_all{1,m});
	rel_errors(m) = norms_exct_apprx(m)/norms_exct(m);
end

%plot relative errors
figure(2);
plot(N, rel_errors);
rel_errors
%rel_errors = [ 0.0897809   0.0328390   0.0137688   0.0017977 ]



% Plot relative errors between 25 and 200
s=25;   % starting value of K
t=200;  % final value of K
rel_errs = zeros(1, t-s+1);
for K = s:t
	h = 1/K;    % Interval size of discretization
	x = 0:h:1;

	%compute exact solution evaluated at K discrete points
	T_exct = zeros(K,1);
	for k = 1:length(x)
		T_exct(k) = T(x(k));
	end
	norm_exct = norm(T_exct);

	%compute approx solution with FD discretization with K points
	[T_apprx, x5] = heatEqnSolver1D(K, f);

	%compute relative error
	norm_exct_apprx = norm(T_exct - T_apprx);
	rel_errs(K-s+1) = norm_exct_apprx/norm_exct;
end

figure(3);
plot([s:t],rel_errs);


% Now starting at K=120 (obtained by looking at the last plot),
% backtrack to find the smallest value of N that
% will assure the relative error is less than err
err = 0.01;
K = 120;
rel_err = rel_errs(K-s+1);
%we use a linear backtracking search

while (K>s)
	K = K - 1;
	if(err == rel_errs(K-s+1))
		break;
	elseif(err < rel_errs(K-s+1))
		K = K+1;
		break;
	end
end

%display the final K and rel_err
K
rel_err = rel_errs(K-s+1)
% K =  106
% rel_err =  0.0033432


