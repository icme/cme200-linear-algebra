function plots_part_e
%Plot condition numbers

N = [5; 10; 25; 200];
cond_numbers = zeros(4, 1);
figure(2);
delta = 0.1;
f = @(x) -10*sin(3*pi*x/2);
c = ['r', 'b', 'k', 'g'];
for k=1:length(N)
  h = 1/(N(k));
% Construct sparse matrix A
  A = spdiags(ones(N(k)-1,2), [-1;1], N(k)-1, N(k)-1) - 2*speye(N(k)-1);

  A = A + delta*A;   % Perturbing the system by delta*A
  x = linspace(0, 1, N(k)+1);  % Find the points of discretization
  xind = x(2:end-1);
  b1 = (h^2)*(f(xind)); % Forming b
  b1(N(k)-1) = b1(N(k)-1) - 2;
  T = A\(b1');    % Solving the system Ax = b
  Tsol = [0; T; 2];

  plot(x', Tsol, c(k));
  hold on

  cond_numbers(k) = cond(full(A),'fro');
end

cond_numbers
%{
   1.2931e+01
   7.6943e+01
   7.8663e+02
   1.4558e+05
%}
legend({'N=5', 'N=10', 'N=25', 'N=200'}, 'Location', 'SouthEast')
hold off

figure(3);
plot(cond_numbers)

