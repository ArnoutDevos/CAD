function selection=selectionTournament(population,NP,V,M)
    %selection=[population(1:NP-2,:); population(end-1:end,:)];
    index = 1:size(population,1);
    index = index(round(NP/5):end);
    selected = [];
    selected = population(1:round(NP/5),:);
    for i=1:NP-round(NP/5)
        a = randi(size(index));
        b = randi(size(index));
        a = index(a);
        b = index(b);
        candidatea = population(a,:);
        candidateb = population(b,:);
        if a>b
            selected = [selected;candidateb];
            index = index(index~=b);
        else
            selected = [selected; candidatea];
            index = index(index~=a);
        end
    end
    
    selection = selected;
end
