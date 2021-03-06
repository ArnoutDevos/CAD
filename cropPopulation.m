function new=cropPopulation(old,nb,V,M)
%new = old(1:nb,:);

%Three step elimination
newpop=old;
oldsize = size(old,1);
tbcut = round((oldsize-nb)/3);
newpop=CDsortPopulation(newpop(1:end-tbcut,1:V+M+1),V,M);
oldsize=oldsize-tbcut;
tbcut = round((oldsize-nb)/2);
newpop=CDsortPopulation(newpop(1:end-tbcut,1:V+M+1),V,M);
new=newpop(1:nb,:);

%Single elimination
% newpop=old;
% while(size(newpop,1)>nb)
%     newpop=CDsortPopulation(newpop(1:end-1,1:V+M+1),V,M);
% end
% new=newpop;
end
