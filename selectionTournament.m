function selection=selectionTournament(population,NP,V,M)
    %selection=[population(1:NP-2,:); population(end-1:end,:)];
    index = 1:size(population,1);
    %index = index(round(NP/5):end);
    selected = [];
    %selected = population(1:round(NP/5),:);
    for i=1:NP
        %for i=1:NP-round(NP/5)
        sizeLeft = size(index);
        a = randi(sizeLeft);
        b = randi(sizeLeft);
        while b == a
            b = randi(sizeLeft);
        end
        a = index(a);
        b = index(b);
        candidatea = population(a,:);
        candidateb = population(b,:);
        if a>b
            a=b;
            index = index(index~=b);
        else
            index = index(index~=a);
        end
        selected = [selected;population(b,:)];
    end
    
    selection = selected;
end
