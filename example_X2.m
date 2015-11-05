clear all;
clf;

% Define the boundaries of the problem.
lb=[0 0 0 0 0 0];
ub=[1 1 1 1 1 1];
V=6;
M=2;
%lb=[-5 -5];
%ub=[5 5];
%V=2;
%M=1;
% Use the GA
res=myGA(@(x) benchmark(3,x),V,M,lb,ub);

