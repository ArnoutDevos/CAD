function children=geneticOperators(parents,NC,P,V,M,f,lb,ub)

PS=size(parents,1);
children =[];
for i = 1:NC
    if(rand > P)
        parent = parents(randi(size(parents,1)),:);
        if parent(V+M+2) == 0
            mask = rand(1,V) < 0.5; 
        else
            mask=rand(1,V)< 0.25;
        end
        parent(1,1:V) = min(max(parent(1,1:V) + mask*0.2.*randn(1,V) ,0),1);
        children = [children; parent(1,1:V)];
    else
%         B=randi(V-1);
%         keuzeA = randi(size(parents,1));
%         keuzeB = randi(size(parents,1));
%         while parents(keuzeB,1:V) == parents(keuzeA,1:V)
%             keuzeB = randi(size(parents,1));
%         end
%         child1 = parents(keuzeA,1:B);
%         child2 = parents(keuzeB,B+1:V);
%         children = [children; child1,child2];

        keuzeA = randi(size(parents,1));
        keuzeB = randi(size(parents,1));
        while parents(keuzeB,1:V) == parents(keuzeA,1:V)
            keuzeB = randi(size(parents,1));
        end
        parentA = parents(keuzeA,:);
        parentB = parents(keuzeB,:);
        child = [];
        for j = 1:V
           if rand < 0.5
               child = [child min(max(parentA(j)+0.1*rand,0),1)];
           else
               child = [child min(max(parentB(j)+0.1*rand,0),1)];
           end
           
        end
        children = [children; child];
    end
end

end
