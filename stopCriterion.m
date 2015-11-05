function [flag, passdownpopulation]=stopCriterion(it,population,previouspopulation,V,M)
% Return :  1 if the GA must continue 
%           0 if the GA must stop
% 
%     flag=1;
%     if it > 400
%         flag=0;
%     end
     passdownpopulation = population;
     rankones = population(population(:,V+M+1)==1,:)
    if (length(previouspopulation) == 0)
        flag = 1;
    elseif  abs(sum(abs(population(:,V+1:V+M))) - sum(abs(previouspopulation(:,V+1:V+M)))) < eps%*abs(sum(abs(population(:,V+1:V+M)))))
        if min(rankones(:,V+M+2))>=0.022
            flag = 0;
        else
           flag = 1; 
        end
    else
       flag = 1; 
    end

end