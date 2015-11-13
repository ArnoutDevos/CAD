%clear all;

addpath('interfaceEldo');
eldo_setup;

lb=[ 10e3 1e-6 1e-6 1e-6 1e-6 1.8];
ub=[ 100e3 10e-6 10e-6 10e-6 10e-6 3.3] ;

% x=rand(10,6);
% for j=1:10
%     x(j,:)=lb+(ub-lb).*x(j,:);
% end

%interfaceEldo('circuitresistiveload',x,1,0)

res=myGA(@(x) interfaceEldo('circuitresistiveload',x,1,0),6,2,lb,ub);
