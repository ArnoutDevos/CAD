function sorted=sortPopulation(unsorted,V,M)

if M==1
   % To be written
    sorted = sortrows(unsorted,V+1); 
else % Multi-objective case : non-domination sorting
    sortedRank = [];
    points = unsorted;
    ok=true;
    rank=1;
    %% Ranking
    % To be written    
    while ~isempty(points)
        indexforthisrank = [];
        for i = 1:size(points,1)
            for j= 1:size(points,1)
               if j~=i
                   dominantergevonden = all(points(i,V+1:V+M) >= points(j,V+1:V+M));
                   if dominantergevonden
                       if points(i,V+1:V+M) == points(j,V+1:V+M)
                            dominantergevonden = false;
                       else
                            ok = false;
                            break
                       end
                   else
                       ok = true;
                   end
               else
                   ok = true;
               end
            end
%             pause
            if ok
                %add to result
                indexforthisrank = [indexforthisrank; i];
            end
        end
        sortedRank = [sortedRank; points(indexforthisrank,:) rank*ones(size(indexforthisrank,1),1)];
        points(indexforthisrank,:) = [];
        rank = rank+1;


        
    end
    %% Crowding Distance
    % To be written
%     k = 0.1; %Fraction of distances which will be considered in crowding distance
%     rank = 1;
%     sortedRankCD = [];
%     CDrank = [];
%     %sortedRank(:,V+M+2) = inf; %Create new column with standard crowding distance set to infinity
%     rankpoints = sortedRank(sortedRank(:,V+M+1)==rank,:);
%     while ~isempty(rankpoints)
%         for i = 1:size(rankpoints,1)
%             for j= 1:size(rankpoints,1)
%                if ~(j==i)
%                    distance = norm(rankpoints(j,V+1:V+M)-rankpoints(i,V+1:V+M));
%                    CDrank = [CDrank; distance];
%                end
%             end
%             sortedDistance = sortrows(CDrank);
%             CDrank = [];
%             if (length(sortedDistance) >= 5)
%                 CD = sum(sortedDistance(1:5));
%             else
%                 CD = sum(sortedDistance);
%             end
%             sortedRankCD = [sortedRankCD; CD];
%         end
%         %sortedRankCD = [sortedRankCD; rankpoints]
%         rank = rank+1;
%         rankpoints = sortedRank(sortedRank(:,V+M+1)==rank,:);
%     end
%     result = [sortedRank,sortedRankCD]; %add CD column to result


    rank = 1;
    rankpoints = sortedRank(sortedRank(:,V+M+1)==rank,:);
    kleinem = 1;
    result = [];
    while ~isempty(rankpoints)
        
        CD = zeros(size(rankpoints,1),1);
        rankpoints = [rankpoints CD];
        while kleinem <= M
           rankpoints = sortrows(rankpoints,V+kleinem);
           rankpoints(1,V+M+2) = inf;
           rankpoints(end,V+M+2) = inf;
           for k=2:(size(rankpoints,1)-1)
               rankpoints(k,V+M+2) = rankpoints(k,V+M+2) + ((rankpoints(k+1,V+kleinem) - rankpoints(k-1,V+kleinem))/(max(rankpoints(:,V+kleinem)) - min(rankpoints(:,V+kleinem))));
           end
           kleinem = kleinem +1;
        end
        result = [result; rankpoints];
        rank = rank+1;
        rankpoints = sortedRank(sortedRank(:,V+M+1)==rank,:);
        kleinem = 1;
    end
    
    result = sortrows(result,[V+M+1,-1*(V+M+2)]);
    
    sorted = result;
end
