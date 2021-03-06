function children=geneticOperators(parents,NC,P,V,M,f,lb,ub,sigmamut,sigmarec)

PS=size(parents,1);
children =[];
for i = 1:NC
    if(rand > P) %mutatie
        parent = parents(randi(size(parents,1)),:);
        if parent(V+M+2) == 0
            mask = rand(1,V) < 0.5; 
        else
            mask=rand(1,V)< 0.25;
        end
        parent(1,1:V) = min(max(parent(1,1:V) + mask*sigmamut.*randn(1,V) ,0),1);
        children = [children; parent(1,1:V)];
    else %recombinatie
    if (rand > 0.3) %binomiale recombinatie met kleine mutatie
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
               newvalue = parentA(j)+sigmarec*randn;
               if newvalue > 1
                   newvalue = 1 - abs(mod(newvalue,1));
               elseif newvalue < 0
                   newvalue = 0 + abs(mod(newvalue,-1));
               end
               child = [child newvalue];
           else
               newvalue = parentB(j)+sigmarec*randn;
               if newvalue > 1
                   newvalue = 1 - abs(mod(newvalue,1));
               elseif newvalue < 0
                   newvalue = 0 + abs(mod(newvalue,-1));
               end
               child = [child newvalue];
           end
           
        end
        children = [children; child];
    else %lineaire interpolatie
                keuzeA = randi(size(parents,1));
        keuzeB = randi(size(parents,1));
        while parents(keuzeB,1:V) == parents(keuzeA,1:V)
            keuzeB = randi(size(parents,1));
        end
        parentA = parents(keuzeA,:);
        parentB = parents(keuzeB,:);
        child = [];
        for j = 1:V
           child = [child (parentA(j)+parentB(j))/2];
           
        end
    end
    end
end

end
