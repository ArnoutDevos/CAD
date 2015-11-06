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
n=3;
itstat = [];
for P=0.3:0.1:0.7
    P
    ittotaal = 0;
    for i = 1:n
        i
        [pop, it] = myGAstat(@(x) benchmark(3,x),V,M,lb,ub,100,50,100,P);
        ittotaal = ittotaal + it;
        
    end
    itstat = [itstat; P ittotaal/n];
end
hold off
plot(itstat(:,1),itstat(:,2),'r')