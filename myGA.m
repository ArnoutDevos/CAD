function [it,population] =myGA(f,V,M,lb,ub)
% myGA(f,V,M,lb,ub)
% f : function to minimize
% V : Dimension of the search space.
% sM : Number of objectives.
% lb = lower bound vector.
% ub = upper bound vector. 

%% DEFINITION OF THE PARAMETERS

N=30;    % Population size
NP=round(N/2);    % Size of the mating pool
NC=2*NP;    % Number of children generated by generation
P=0.7;     % probability of recombination
Q=1;    %measures how long we've been iterating
QDropOff = 0.993;
sigma = 0.38; %mutation std control

verbose=1;

%% GENETIC ALGORITHM

% Generation of the intial population
population=initPopulation(N,V);
population=evaluatePopulation(population,f,V,M,lb,ub);

population=sortPopulation(population,V,M);

% Main loop


sigmamut = sigma;
sigmarec = sigma/20;
flag = true;
previouspopulation = [];
it=1;
T=0;
while flag
    tic
    P=1-Q;
    sigmamut=Q*sigma;
    sigmarec=min(sigma,sigma/20/Q);
    NC = round(N/2+(2*N-N/2)*Q*Q);
    Q=Q*QDropOff;

    
    parents=selectionTournament(population,NP,V,M);	
    
    offspring=geneticOperators(parents,NC,P,V,M,f,lb,ub,sigmamut,sigmarec);
    
    offspring = evaluatePopulation(offspring,f,V,M,lb,ub);
    population = [ population(:,1:V+M) ; offspring(:,1:V+M) ];
    
    population=sortPopulation(population,V,M);
    

    
    population=cropPopulation(population,N,V,M);

    
    [flag, previouspopulation] = stopCriterion(it,population,previouspopulation,V,M,N);

    T=T+toc;
    if verbose
         figure(1)
         hold off
         plot(population(:,V+1),population(:,V+2),'x')
         title(['Search Space, Iteration ' num2str(it)])
    %     t=0:0.01:1;
    %     hold on
    %     plot(t,1-t.^2,'r');
    end
        
    it=it+1;

end
it = it-1;
%disp(['Totale iteratietijd ', num2str(T), ' s'])
figure(1)
hold off
plot(population(:,V+1),population(:,V+2),'x')
title(['Search Space, Iteration ' num2str(it)])
t=0:0.01:1;
hold on
plot(t,1-t.^2,'r');
pause(0.1)
end
