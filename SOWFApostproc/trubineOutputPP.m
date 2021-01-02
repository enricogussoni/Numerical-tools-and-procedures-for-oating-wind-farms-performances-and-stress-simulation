function [timeHistory,time] = trubineOutputPP(variableName,unitOfMeasure)

% Objects of trubineOutputPP must be strings like 'rotorPower' and 'W'.
% Enrico Gussoni 2019


data = importdata(variableName);
time = data.data(:,2); % dt = data.data(1,3);
timeHistory = data.data(:,4);

figure
plot(time,timeHistory)
title(variableName); xlabel('Time [s]'); ylabel([variableName ' [ ' unitOfMeasure ' ]']);