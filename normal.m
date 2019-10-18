clc;
clear;
close all;
tuSize =  128;

divDyx = [8 0];
for i = 1:tuSize
    divValueInter(i,1) = floor(i*divDyx(1,1)/(2^divDyx(1,2)))
    divValueDouble(i,1) = (i*divDyx(1,1)/(2^divDyx(1,2)))
end

for i = 1:tuSize-1
    divValueDiff(i,1) = divValueInter(i+1,1) - divValueInter(i,1)
    divValueDoubleDiff(i,1) = divValueDouble(i+1,1) - divValueDouble(i,1)
end
% value plot
%x  = 1:size(divValueInter);
%plot(x, divValueInter);
%hold on;
%plot(x, divValueDouble);

%value diff  scatter
x  = 1:size(divValueDiff);
scatter(x, divValueDiff);
hold on;
scatter(x, divValueDoubleDiff);


%value   scatter
% x  = 1:size(divValueInter);
% scatter(x, divValueInter);
% hold on;
% scatter(x, divValueDouble);