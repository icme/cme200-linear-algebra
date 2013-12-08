%% Construct our page rank matrix 
% Load data
load movies.mat ;

% Construct the matrices C and B
C = sparse(links(:,1), links(:,2), 1, 928, 32326);
B=C*C';

% Remove the diagonal
B = B - diag(diag(B));

% Ignore number of shared actors
B=B>0;

% Normalize these rows; this is the PageRank matrix
P = B*diag(1 ./ sum(B,1));

% Sparsity plot
spy(P)

%%

% initialize values
alpha = .85;
v = ones(size(P,1),1) / size(P,1);

% Simple solve works in this case
pr = (eye(size(P,1)) - alpha*P)\v;

% normalize rank
pr = pr/norm(pr,1);

% sort and display top 5 ranked movies
[pr_sorted , sort_index] = sort(pr, 'descend');

for i= 1:5
    fprintf(1, '%f = %s (%s)\n', ...
    pr_sorted(i), movieName{sort_index(i)}, movieIMDbID{sort_index(i)});
end

%% Jacobi PageRank iteration

maxiter = 1e4; % more than enough
tol = 1e-4; 
alpha =0.85;

% pre-allocate an array to keep track of step length and iteration
iter_alloc = zeros(maxiter ,1);
step_length = zeros(maxiter ,1);

% previous iterate
x_old = zeros(size(P,1),1);

for iter = 1: maxiter
    
	% next iterate
	x_new = alpha*P*x_old + v;

	% calculate convergenc measure
	step_length(iter) = norm(x_new - x_old ,1)/norm(x_new ,1);

	iter_alloc(iter) = iter;

	if step_length(iter) < tol
        break % convergence achieved! end
    end
    
	% update old iterate to current iterate
	x_old = x_new;
    
end

% delete ununsed allocation
step_length = step_length(1:iter);
iter_alloc = iter_alloc(1:iter);

% normalize each solution and compare
x_new = x_new/norm(x_new ,1);

fprintf(1, 'Terminated in %d steps; normed difference in solutions is %f\n',...
iter, norm(x_new - pr))

% create plots
subplot(2,1,1), plot(iter_alloc , step_length)
title('Convergence per iterate , linear scale'); subplot(2,1,2), semilogy(iter_alloc , step_length)
title('Convergence per iterate, log-linear scale')

%% Plots

% PageRank vs. # of votes
subplot(2,1,1), plot(pr, movieVotes , 'b.');
title('PageRank vs. # of Votes')

% PageRank vs. movie rating
subplot(2,1,2), plot(pr, movieRating , 'b.');
title('PageRank vs movie rating')