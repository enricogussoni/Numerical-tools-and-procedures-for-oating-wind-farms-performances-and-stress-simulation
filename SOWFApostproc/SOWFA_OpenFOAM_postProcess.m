%% SOWFAST OUTPUT READER
% Enrico Gussoni 2019

clear
close all


%% Case loading - SOWFA

[sowfast64, time64] = SOWFAstruct('sowfast64');
[sowfast192, time192] = SOWFAstruct('sowfast192');
[sowfast512, time512] = SOWFAstruct('sowfast512');

close all

%% CAse loading - FAST

%fastOut = importdata('NREL5MWRef.0.out');

caseName = 'sowfast64';
filename = [pwd '/' caseName '/out2/NREL5MWRef.0.out'];
NREL5MWRef0outLoading;
fast64 = NREL5MWRef; 
clear NREL5MWRef filename;

caseName = 'sowfast192';
filename = [pwd '/' caseName '/out2/NREL5MWRef.0.out'];
NREL5MWRef0outLoading;
fast192 = NREL5MWRef; 
clear NREL5MWRef filename;

caseName = 'sowfast512';
filename = [pwd '/' caseName '/out2/NREL5MWRef.0.out'];
NREL5MWRef0outLoading;
fast512 = NREL5MWRef; 
clear NREL5MWRef filename;


%% Case comparison

% Rotor power
figure(1)
plot(time64,sowfast64.rotorPower); hold on
plot(time192,sowfast192.rotorPower); hold on
plot(time512,sowfast512.rotorPower); hold off

% Rotor axial force
figure(2)
plot(time64,sowfast64.rotorAxialForce); hold on
plot(time192,sowfast192.rotorAxialForce); hold on
plot(time512,sowfast512.rotorAxialForce); hold off

% Rotor torque
figure(3)
plot(time64,sowfast64.rotorTorque); hold on
plot(time192,sowfast192.rotorTorque); hold on
plot(time512,sowfast512.rotorTorque); hold off

% Rotor speed
figure(4)
plot(time64,sowfast64.rotorSpeed); hold on
plot(time192,sowfast192.rotorSpeed); hold on
plot(time512,sowfast512.rotorSpeed); hold off

% Tower axial force
figure(5)
plot(time64,sowfast64.towerAxialForce); hold on
plot(time192,sowfast192.towerAxialForce); hold on
plot(time512,sowfast512.towerAxialForce); hold off

%% Mesh sensitivity analysis

time = 10; 
Time64 = time64(time64<time);
Time192 = time192(time192<time);
Time512 = time512(time512<time);

% Rotor power
figure(1)
plot(Time64,sowfast64.rotorPower(1:length(Time64))); hold on
plot(Time192,sowfast192.rotorPower(1:length(Time192))); hold on
plot(Time512,sowfast512.rotorPower(1:length(Time512))); hold off

% Rotor axial force
figure(2)
plot(Time64,sowfast64.rotorAxialForce(1:length(Time64))); hold on
plot(Time192,sowfast192.rotorAxialForce(1:length(Time192))); hold on
plot(Time512,sowfast512.rotorAxialForce(1:length(Time512))); hold off

% Rotor torque
figure(3)
plot(Time64,sowfast64.rotorTorque(1:length(Time64))); hold on
plot(Time192,sowfast192.rotorTorque(1:length(Time192))); hold on
plot(Time512,sowfast512.rotorTorque(1:length(Time512))); hold off

% Rotor speed
figure(4)
plot(Time64,sowfast64.rotorSpeed(1:length(Time64))); hold on
plot(Time192,sowfast192.rotorSpeed(1:length(Time192))); hold on
plot(Time512,sowfast512.rotorSpeed(1:length(Time512))); hold off

% Tower axial force
figure(5)
plot(Time64,sowfast64.towerAxialForce(1:length(Time64))); hold on
plot(Time192,sowfast192.towerAxialForce(1:length(Time192))); hold on
plot(Time512,sowfast512.towerAxialForce(1:length(Time512))); hold off