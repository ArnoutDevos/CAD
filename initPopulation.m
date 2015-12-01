function population=initPopulation(N,V)
%initPopulation(N,V)
%population = rand(N,V);
population = lhsdesign(N,V);
%population = [zeros(floor(N/2),V);ones(ceil(N/2),V)];

end
