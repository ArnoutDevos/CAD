clear all;

addpath('interfaceEldo');
eldo_setup;

lb=[ 1e3 1e-9];
ub=[ 10e3 5e-9] ;

x=rand(10,2);
for j=1:10
    x(j,:)=lb+(ub-lb).*x(j,:);
end

interfaceEldo('circuit1',x,1);

res=myGA(@(x) interfaceEldo('circuit1',x,0),2,3,lb,ub);
