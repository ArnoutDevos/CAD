

function [population,it]=myGA(f,V,M,lb,ub,N,NP,NC,P)
% myGA(f,V,M,lb,ub)
% f : function to minimize
% V : Dimension of the search space.
% sM : Number of objectives.
% lb = lower bound vector.
% ub = upper bound vector. 

%% DEFINITION OF THE PARAMETERS

%parameters are arguments now

verbose=0;

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

    parents=selectionTournament(population,NP,V,M);	
    
    offspring=geneticOperators(parents,NC,P,V,M,f,lb,ub);
    
    offspring = evaluatePopulation(offspring,f,V,M,lb,ub);
    population = [ population(:,1:V+M) ; offspring(:,1:V+M) ];
    
    population=sortPopulation(population,V,M);
    

    
    population=cropPopulation(population,N);

    % Visualization
    if verbose
        illustratePopulation(population,V,M,lb,ub,it);
        drawnow;
        %pause(0.1);
    end

        
    it=it+1;
    [flag, previouspopulation] = stopCriterion(it,population,previouspopulation,V,M);
end
    hold off
    scatter(population(:,V+1),population(:,V+2))
    t=0:0.01:1;
    hold on
    plot(t,1-t.^2,'r');
    pause(0.1)
it = it - 1

end