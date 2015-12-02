function sorted=CDsortPopulation(sortedRank,V,M)

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
