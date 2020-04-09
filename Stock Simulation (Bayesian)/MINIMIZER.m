clc;clear;

bound = [-10 10];

myfun = @(x) (x-2)^2;
init  = -9;

% options for local solver (use fmincon) 
options = optimoptions('fmincon','Algorithm','interior-point',...
        'TolFun', 1e-18, 'TolX', 1e-18, 'Display', 'iter', ...
        'GradObj', 'off', 'Diagnostics', 'on',...
        'MaxFunEvals', 1e7,'MaxIter', 500);

   
% run fmincon    
[para,fval,exitflag,output,lambda,grad,hessian] = fmincon(myfun,init,[],[],[],[],bound(:,1),bound(:,2),[],options);

para