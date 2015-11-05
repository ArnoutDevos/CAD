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
        parent(1:V) = min(max(parent(1:V) + mask*0.2.*randn(1,V) ,0),1);
        children = [children; parent(1:V)];
    else
        B=randi(V-1);
        child1 = parents(randi(size(parents,1)),1:B);
        child2 = parents(randi(size(parents,1)),B+1:V);
        children = [children; child1,child2];
    end
end

end
