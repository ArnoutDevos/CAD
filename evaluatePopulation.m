function population=evaluatePopulation(population,f,V,M,lb,ub)

variablesDesign = population(:,1:V);
%Denormalization
variablesDesign = variablesDesign * diag(ub-lb) + ones(size(variablesDesign))*diag(lb);

result = [];
for i = 1:size(population,1)
    
   result = [result; f(variablesDesign(i,:))];
end
% result = f(variablesDesign(:,1:V));
 population = [population(:,1:V) result];

end
