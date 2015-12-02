ittotaal=[];
for i=1:100
    example_X2;
    ittotaal=[ittotaal;it];
end
disp(['gemiddeld aanal iteraties: ',num2str(mean(ittotaal))])