A = -2*diag(ones(3,1)) + diag(ones(2,1),-1) + diag(ones(2,1),1);
   v1 = [2 0 0]'; v2 = A*v1;
   lam1 = 1; lam2 = v1'*v2;
   v2 = v2/norm(v2);
   err = abs(lam2-lam1)/abs(lam1);
   i=1;
   while abs(lam2-lam1)/abs(lam1) > 10^-6 || i<60
   v1 = v2; v2 = A*v1;
   lam1 = lam2; lam2 = v1'*v2;
   v2 = v2/norm(v2);
   i=i+1;
   err(i) = abs(lam2-lam1)/abs(lam1);
   end
   v1
   lam1