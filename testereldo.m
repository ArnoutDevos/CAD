%clear all;

addpath('interfaceEldo');
eldo_setup;

%lb=[ 10e3 1e-6 0.5e-6 1e-6 0.5e-6 1.8 1e-6 0.5e-6 1.8];
%ub=[ 100e3 10e-6 3e-6 10e-6 3e-6 3.3 10e-6 3e-6 3.3] ;
lb=[ 10e3 1e-6 0.5e-6 1e-6 0.5e-6 1.8 1.8];
ub=[ 1000e3 10e-6 3e-6 10e-6 3e-6 3.3 2.4] ;

% x=rand(10,6);
% for j=1:10
%     x(j,:)=lb+(ub-lb).*x(j,:);
% end

%interfaceEldo('circuitresistiveload',x,1,0)

res=myGA(@(x) interfaceEldo('circuitresistiveload',x,1,0),size(ub,2),2,lb,ub);

res(:,size(ub,2)+1) = -1*res(:,size(ub,2)+1);
res(:,size(ub,2)+3:size(ub,2)+4) = [];
variablesDesign = res(:,1:size(ub,2));
variablesDesign = variablesDesign * diag(ub-lb) + ones(size(variablesDesign))*diag(lb);
res(:,1:size(ub,2))=variablesDesign;
figure(3)
plot(res(:,size(ub,2)+1),res(:,size(ub,2)+2),'x')
