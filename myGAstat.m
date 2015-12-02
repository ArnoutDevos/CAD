

function [it,population]=myGA(f,V,M,lb,ub,N,PopDivider,QFactor,gamma)
% myGA(f,V,M,lb,ub)
% f : function to minimize
% V : Dimension of the search space.
% sM : Number of objectives.
% lb = lower bound vector.
% ub = upper bound vector. 

%% DEFINITION OF THE PARAMETERS

%parameters are arguments now
NP=round(N/PopDivider);    % Size of the mating pool
P=0;     % probability of recombination
Q=1;    %measures how long we've been iterating

%% GENETIC ALGORITHM

% Generation of the intial population
population=initPopulation(N,V);
population=evaluatePopulation(population,f,V,M,lb,ub);

population=sortPopulation(population,V,M);

% Main loop

flag = true;
previouspopulation = [];
it=1;
while flag
    
    P=1-Q;

    sigmamut=Q*gamma;
    sigmarec=min(gamma,gamma/20/Q);
    NC = round(NP+(2*N-NP)*Q*Q);
    Q=Q*QFactor;
    
    parents=selectionTournament(population,NP,V,M);	
    
    offspring=geneticOperators(parents,NC,P,V,M,f,lb,ub,sigmamut,sigmarec);
    
    offspring = evaluatePopulation(offspring,f,V,M,lb,ub);
    population = [ population(:,1:V+M) ; offspring(:,1:V+M) ];
    
    population=sortPopulation(population,V,M);
    

    
    population=cropPopulation(population,N,V,M);
        
    it=it+1;
    [flag, previouspopulation] = stopCriterion(it,population,previouspopulation,V,M,N);
end
    hold off
    it = it-1
    plot(population(:,V+1),population(:,V+2),'x')
    title(['Search Space, Iteration ' num2str(it)])

end