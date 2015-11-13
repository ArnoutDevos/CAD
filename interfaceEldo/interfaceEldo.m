function obj = interfaceEldo(filename,x,verbose,dotran)
%SPEEDUP, remove ]);%>  /dev/null']); after each unix command
    % Example for DC simulations
    injectValues(filename,x,'dc');
    unix(['eldo interfaceEldo/' filename '/dc> /dev/null']);
    dataDC=extractDC(filename);
    
    if dotran == 1
    % Example for Transient simulations
    injectValues(filename,x,'tran');
    unix(['eldo interfaceEldo/' filename '/tran> /dev/null']);
    dataTran=extractTran(filename);
    
    if verbose ==1
        for j=1:10
            hold off
            plot(dataTran{j}.time,dataTran{j}.X);
            drawnow;
            pause;
        end
    end
    end
    
    % Example for AC simulations
    injectValues(filename,x,'ac');
    unix(['eldo interfaceEldo/' filename '/ac > /dev/null']);
    dataAC=extractAC(filename);
    figure(2)
    hold off
    if verbose == 1
        for j=1:10
             %loglog(dataAC{j}.f, sum([dataAC{j}.RX dataAC{j}.IX].^2,2) );
             loglog(dataAC{j}.f, sqrt(sum([dataAC{j}.RX dataAC{j}.IX].^2,2))/0.02 );
            drawnow;
            hold on
            %plot(dataAC{j}.f, 0.5*ones(size(dataAC{j}.f))*sqrt(sum([dataAC{j}.RX(2) dataAC{j}.IX(2)].^2,2))/0.02)
            %pause;
        end
    end
    hold off
    GBW=[];
    for j=1:50
        Gain    = norm([dataAC{j}.RX(1) dataAC{j}.IX(1)])/0.02;
        [a index] = min(abs(sum([dataAC{j}.RX dataAC{j}.IX].^2,2)-ones(size(dataAC{j}.f))*0.5*sum([dataAC{j}.RX(1) dataAC{j}.IX(1)].^2,2)));
        BW      = dataAC{j}.f(index);
        GBW=[GBW; Gain*BW];
    end
    
    
    % Compute objectives
    obj(:,1)= -1*GBW;
    obj(:,2)=dataDC*3.3;
    %obj(:,3)=;
    
end

