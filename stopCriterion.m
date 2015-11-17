function [flag, passdownpopulation]=stopCriterion(it,population,previouspopulation,V,M,N)
% Return :  1 if the GA must continue 
%           0 if the GA must stop
% 
%     flag=1;
%     if it > 400
%         flag=0;
%     end
     passdownpopulation = population;
     rankones = population(population(:,V+M+1)==1,:);
     rankones(rankones(:,V+M+2)==Inf,:) = [];
     
     sorted1 = sortrows(population(:,V+1:V+M),1);
    
     newArea = calcArea(sorted1(:,1:M),M);
     oldArea=Inf;
     if (length(previouspopulation)~=0)
        sorted2 = sortrows(previouspopulation(:,V+1:V+M),1);
        oldArea = calcArea(sorted2(:,1:M),M);
     end
     
    if (length(previouspopulation) == 0)
        flag = 1;
    elseif it> 300
        flag = 0;
    %elseif abs(trapz(sorted1(:,1),sorted1(:,2))-trapz(sorted2(:,1),sorted2(:,2)))<1e-9
%     elseif max(population(:,V+M+1)) <= 2
%         %if  (abs(sum(abs(population(:,V+1:V+M))) - sum(abs(previouspopulation(:,V+1:V+M)))) < 1e-3*abs(sum(abs(population(:,V+1:V+M)))))
%         newtrap = trapz(sorted1(:,1),sorted1(:,2));
%         if abs((newtrap-trapz(sorted2(:,1),sorted2(:,2)))/newtrap)<5e-4
%             if mean(rankones(:,V+M+2))/std(rankones(:,V+M+2))>= 2
%                 flag = 0;
%             else
%                 flag = 1;
%                 mean(rankones(:,V+M+2))/std(rankones(:,V+M+2))
%             end
%         else
%              flag = 1;
%              abs((newtrap-trapz(sorted2(:,1),sorted2(:,2)))/newtrap)
%         end
    elseif abs((newArea-oldArea)/newArea) < 2e-6 && std(sorted1(:,M)) < 1/N
        flag = 0;
    else
       flag = 1;     
       max(population(:,V+M+1))
    end

end