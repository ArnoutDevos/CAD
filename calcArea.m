function area = calcArea(data,M)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [x,ia,~]=unique(data(:,1));
    y=data(:,M);
    y=y(ia);
    area = trapz(x,y);
end

