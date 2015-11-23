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
               ok=true; %Assume every point is in this rank, unless contradicted so + By definition, a point always dominates itself
               if j~=i
                   % If there exists a point j which is smaller or equal
                   % for the objectives, then point j 'dominates' or point
                   % of interest i.
                   dominated = all(points(i,V+1:V+M) >= points(j,V+1:V+M));
                   if dominated
                       % Check wether they have the same objective results,
                       % if so then go on searching for other dominating
                       % points.
                       if ~isequal(points(i,V+1:V+M),points(j,V+1:V+M))
                            % A more dominant point j has been found, abort
                            % searching and go on to next point i.
                            ok = false;
                            break
                       end
                   else
                   end
               end
            end
            if ok
                %add to result
                indexforthisrank = [indexforthisrank; i];
            end
        end
        sortedRank = [sortedRank; points(indexforthisrank,:) rank*ones(size(indexforthisrank,1),1)];
        points(indexforthisrank,:) = [];
        rank = rank+1;
    end
    
    %sortedRank = sortrows(sortedRank,V+M+1);
    %% Crowding Distance
    % To be written
%     k = 0.5; %Fraction of distances which will be considered in crowding distance
%     rank = 1;
%     sortedRankCD = [];
%     CDrank = [];
%     %sortedRank(:,V+M+2) = inf; %Create new column with standard crowding distance set to infinity
%     rankpoints = sortedRank(sortedRank(:,V+M+1)==rank,:);
%     while ~isempty(rankpoints)
%         for i = 1:size(rankpoints,1)
%             for j= 1:size(rankpoints,1)
%                if ~(rankpoints(j,1:V)==rankpoints(i,1:V))
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
%    result = sortrows(result,[V+M+1,-(V+M+2)]);


% ------ Algorithm Paper implementation
    rank = 1;
    rankpoints = sortedRank(sortedRank(:,V+M+1)==rank,:);
    result = [];
    while ~isempty(rankpoints)
        
        CD = zeros(size(rankpoints,1),1);
        rankpoints = [rankpoints CD];
        littlem = 1;
        while littlem <= M
           rankpoints = sortrows(rankpoints,V+littlem);
           rankpoints(1,V+M+2) = inf;
           rankpoints(end,V+M+2) = inf;
           for k=2:(size(rankpoints,1)-1)
               rankpoints(k,V+M+2) = rankpoints(k,V+M+2) + ((rankpoints(k+1,V+littlem) - rankpoints(k-1,V+littlem))/(max(rankpoints(:,V+littlem)) - min(rankpoints(:,V+littlem))));
           end
           littlem = littlem +1;
        end
        result = [result; rankpoints];
        rank = rank+1;
        rankpoints = sortedRank(sortedRank(:,V+M+1)==rank,:);
    end

% % ---------- Euclidian Distance Implementation
%     rank = 1;
%     rankpoints = sortedRank(sortedRank(:,V+M+1)==rank,:);
%     result = [];
%     while ~isempty(rankpoints)
%         CD = zeros(size(rankpoints,1),1);
%         vectors = rankpoints(:,V+1:V+M)';
%         distances = dist(vectors);
%         for i = 1:size(rankpoints,1)
%             %sorted = sortrows(distances(:,i));
%             distances(i,i)=Inf;
%             %sorted = (sorted ~= 0);
%             distances = distances(distances(:,i) ~= Inf);
%             if ~isempty(distances)
%                 CD(i) = min(distances);
%             else
%                 CD(i) = 0;
%             end
%             
%         end
%         rankpoints = [rankpoints CD];
%         result = [result; rankpoints];
%         rank = rank+1;
%         rankpoints = sortedRank(sortedRank(:,V+M+1)==rank,:);
%     end
    
    result = sortrows(result,[V+M+1,-1*(V+M+2)]);
    
     sorted = result;
end
