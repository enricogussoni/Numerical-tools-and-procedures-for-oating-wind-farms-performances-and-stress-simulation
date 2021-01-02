%% Post-processing
% General case
%
% PAY ATTENTION: import the .out file and than save the workspace in a
% variable called workSpaceON.mat if HydroDyn is enabled (workSpaceOFF.mat
% otherwise).

close all
clear all
clc

CASE = char('ON'); % Set ON if HydroDyn is enabled, OFF otherwise

if strcmp(CASE,'ON')
    load workSpaceON.mat
    fprintf('Case with HydroDyn enabled\n\n')
else
    load workSpaceOFF.mat
    fprintf('Case without HydroDyn enabled\n\n')
end

%% 1) InflowWind output
figure(11)
plot(Time,Wind1VelX); hold on
plot(Time,Wind1VelY); hold on
plot(Time,Wind1VelZ); hold off
legend('Wind1VelX','Wind1VelY','Wind1VelZ')
title('Wind velocity [m/s]'); xlabel('Time [s]')

avWind1VelX = mean(Wind1VelX); % Average wind velocity along x
avWind1VelY = mean(Wind1VelY); % Average wind velocity along y
avWind1VelZ = mean(Wind1VelZ); % Average wind velocity along z
fprintf(' Average wind velocity:\n x: %f [m/s] \n y: %f [m/s] \n z: %f [m/s] \n',avWind1VelX,avWind1VelY,avWind1VelZ);

%% 2) ElastoDyn output
figure(2101)
plot(Time,OoPDefl1); hold on
plot(Time,IPDefl1); hold off
legend('Out-of-plane','In-plane')
title('Blade 1 tip deflection [m]'); xlabel('Time [s]')

avOoPDefl1 = mean(OoPDefl1); avIPDefl1 = mean(IPDefl1);
fprintf('\n Average blade 1 tip deflection: \n Out-of-plane: %f [m] \n In-plane: %f [m] \n',avOoPDefl1,avIPDefl1)

% figure(2102)
% plot(Time,OoPDefl2); hold on
% plot(Time,IPDefl2); hold off
% legend('Out-of-plane','In-plane')
% title('Blade 2 tip deflection [m]'); xlabel('Time [s]')
% 
% avOoPDefl2 = mean(OoPDefl2); avIPDefl2 = mean(IPDefl2);
% fprintf('\n Average blade 2 tip deflection: \n Out-of-plane: %f [m] \n In-plane: %f [m] \n',avOoPDefl2,avIPDefl2)

% figure(2103)
% plot(Time,OoPDefl3); hold on
% plot(Time,IPDefl3); hold off
% legend('Out-of-plane','In-plane')
% title('Blade 3 tip deflection [m]'); xlabel('Time [s]')
% 
% avOoPDefl3 = mean(OoPDefl3); avIPDefl3 = mean(IPDefl3);
% fprintf('\n Average blade 3 tip deflection: \n Out-of-plane: %f [m] \n In-plane: %f [m] \n',avOoPDefl3,avIPDefl3)

figure(220)
%plot(Time,TwstDefl1); hold on
plot(Time,BldPitch1); % hold on
% plot(Time,BldPitch2); hold on
% plot(Time,BldPitch3); hold off
%legend('Torsional defl.','Pitch angle')
%title('Blade 1 torsional tip deflection [deg]');
title('Blade pitch [deg]'); xlabel('Time [s]')

figure(230)
subplot(2,1,1)
plot(Time,RotSpeed);
legend('RotSpeed')
title('Rotor speed [rpm]'); xlabel('Time [s]')
subplot(2,1,2)
plot(Time,GenSpeed);
legend('GenSpeed')
title('Generator speed [rpm]'); xlabel('Time [s]')

% figure(240)
% plot(Time,TwHt1TPxi); hold on
% plot(Time,TwHt1TPyi); hold off
% legend('TwHt1TPxi','TwHt1TPyi')
% title('Tower fore-aft and side-to-side displacements and top twist [m]'); xlabel('Time [s]')
% 
% avTwHt1TPxi = mean(TwHt1TPxi); avTwHt1TPyi = mean(TwHt1TPyi);
% fprintf('\n Average tower displacements: \n Fore-aft: %f [m] \n Side-to-side: %f [m] \n',avTwHt1TPxi,avTwHt1TPyi)
% 
% figure(240)
% plot(Time,TwHt1TPxi); hold on
% plot(Time,TwHt1TPyi); hold off
% legend('TwHt1TPxi','TwHt1TPyi')
% title('Tower fore-aft and side-to-side displacements and top twist [m]'); xlabel('Time [s]')

figure(250)
plot(Time,PtfmSurge); hold on
plot(Time,PtfmSway); hold on
plot(Time,PtfmHeave); hold off
legend('Surge','Sway','Heave')
title('Platform horizontal displacement [m]'); xlabel('Time [s]')

avPtfmSurge = mean(PtfmSurge); avPtfmSway = mean(PtfmSway);
fprintf('\n Average platform horizontal displacement: \n Fore-aft: %f [m] \n Side-to-side: %f [m] \n',avPtfmSurge,avPtfmSway)

figure(260)
plot(Time,PtfmRoll); hold on
plot(Time,PtfmPitch); hold on
plot(Time,PtfmYaw); hold off
legend('Roll','Pitch','Yaw')
title('Platform angular displacement [deg]'); xlabel('Time [s]')

avPtfmRoll = mean(PtfmRoll); avPtfmPitch = mean(PtfmPitch);
fprintf('\n Average platform angular displacement: \n Fore-aft: %f [deg] \n Side-to-side: %f [deg] \n',avPtfmRoll,avPtfmPitch)

% figure(270)
% plot(Time,Spn2MLxb1); hold on
% plot(Time,Spn2MLyb1); hold off
% legend('x','y')
% title('Blade 1 local flapwise moment [kN*m]'); xlabel('Time [s]')
% 
% avSpn2MLxb1 = mean(Spn2MLxb1); avSpn2MLyb1 = mean(Spn2MLyb1);
% fprintf('\n Average blade 1 local flapwise moment: \n Fore-aft: %f [kN*m] \n Side-to-side: %f [kN*m] \n',avSpn2MLxb1,avSpn2MLyb1)

figure(271)
plot(Time,RootFxc1); hold on
plot(Time,RootFyc1); hold on
plot(Time,RootFzc1); hold off
legend('out-of-plane','in-plane','axial')
title('Blade 1 force at the blade root [kN]'); xlabel('Time [s]')

avRootFxc1 = mean(RootFxc1); 
avRootFyc1 = mean(RootFyc1); 
avRootFzc1 = mean(RootFzc1); 
fprintf('\n Average Blade 1 force at the blade root:\n x: %f [kN] \n y: %f [kN] \n z: %f [kN] \n',avRootFxc1,avRootFyc1,avRootFzc1);

figure(272)
plot(Time,RootMxc1); hold on
plot(Time,RootMyc1); hold on
plot(Time,RootMzc1); hold off
legend('out-of-plane','in-plane','axial')
title('Blade 1 force at the blade root [kN]'); xlabel('Time [s]')

avRootMxc1 = mean(RootMxc1); 
avRootMyc1 = mean(RootMyc1); 
avRootMzc1 = mean(RootMzc1); 
fprintf('\n Average blade 1 moment at the blade root:\n x: %f [kN] \n y: %f [kN] \n z: %f [kN] \n',avRootMxc1,avRootMyc1,avRootMzc1);

figure(280)
plot(Time,RotTorq);
title('Rotor torque [kN*m]'); xlabel('Time [s]')

avRotTorq = mean(RotTorq);
fprintf('\n Average rotor torque: %f [kN*m] \n',avRotTorq);

% figure(281)
% plot(Time,RotThrust);
% title('Rotor thrust [kN]'); xlabel('Time [s]')

% avRotThrust = mean(RotThrust);
% fprintf('\n Average rotor thrust: %f [kN] \n',avRotThrust);

figure(290)
plot(Time,LSSGagMya); hold on
plot(Time,LSSGagMza); hold off
legend('y','z')
title('Rotating LSS bending moment at the shaft s strain gage [kN*m]'); xlabel('Time [s]')

figure(291)
plot(Time,YawBrFxp); hold on
plot(Time,YawBrFyp); hold on
plot(Time,YawBrFzp); hold off
legend('x','y','z')
title('Tower-top / yaw bearing shear [N]'); xlabel('Time [s]')

avYawBrFxp = mean(YawBrFxp); 
avYawBrFyp = mean(YawBrFyp); 
avYawBrFzp = mean(YawBrFzp);  
fprintf('\n Average tower-top / yaw bearing shear:\n x: %f [N] \n y: %f [N] \n z: %f [N] \n',avYawBrFxp,avYawBrFyp,avYawBrFzp);

figure(292)
plot(Time,YawBrMxp); hold on
plot(Time,YawBrMyp); hold on
plot(Time,YawBrMzp); hold off
legend('x','y','z')
title('Tower-top / yaw bearing roll moment [kN*m]'); xlabel('Time [s]')

avYawBrMxp = mean(YawBrMxp); 
avYawBrMyp = mean(YawBrMyp); 
avYawBrMzp = mean(YawBrMzp);  
fprintf('\n Average tower-top / yaw bearing roll moment:\n x: %f [kN*m] \n y: %f [kN*m] \n z: %f [kN*m] \n',avYawBrMxp,avYawBrMyp,avYawBrMzp);

% figure(293)
% plot(Time,NacYaw);
% title('Nacelle yaw [deg]'); xlabel('Time [s]')

% figure(294)
% plot(Time,NcIMUTAxs); hold on
% plot(Time,NcIMUTAys); hold on
% plot(Time,NcIMUTAzs); hold off
% legend('x','y','z')
% title('Nacelle inertial measurement unit translational acceleration [m/s^2]'); xlabel('Time [s]')

figure(295)
plot(Time,TTDspFA); hold on
plot(Time,TTDspSS); hold off
legend('fore-aft','side-to-side')
title('Tower-top / yaw bearing (translational) deflection [m]'); xlabel('Time [s]')

% figure(296)
% plot(Time,Spn1MLxb1); hold on
% plot(Time,Spn1MLyb1); hold on
% plot(Time,Spn1MLzb1); hold off
% legend('x','y','z')
% title('Blade 1 local edgewise moment at span station 1 [kN*m]'); xlabel('Time [s]')

figure(297)
plot(Time,TwrBsFxt); hold on
plot(Time,TwrBsFyt); hold on
plot(Time,TwrBsFzt); hold off
legend('fore-aft','side-to-side','axial')
title('Tower base force [kN]'); xlabel('Time [s]')

figure(298)
plot(Time,TwrBsMxt); hold on
plot(Time,TwrBsMyt); hold on
plot(Time,TwrBsMzt); hold off
legend('fore-aft','side-to-side','axial')
title('Tower base moment [kN*m]'); xlabel('Time [s]')

% Computed but not plotted:
%       21  TwrClrnc1   (m)         ElastoDyn
%       22  TwrClrnc2   (m)         ElastoDyn
%       23  TwrClrnc3   (m)         ElastoDyn
%       29  TTDspTwst   (deg)       ElastoDyn
%       36  PtfmTAxt    (m/s^2)     ElastoDyn
%       37  PtfmTAyt    (m/s^2)     ElastoDyn
%       38  PtfmTAzt    (m/s^2)     ElastoDyn
%       45  RootFxc2    (kN)        ElastoDyn
%       46  RootFyc2    (kN)        ElastoDyn
%       47  RootFzc2    (kN)        ElastoDyn
%       48  RootMxc2    (kN·m)      ElastoDyn
%       49  RootMyc2    (kN·m)      ElastoDyn
%       50  RootMzc2    (kN·m)      ElastoDyn
%       51  RootFxc3    (kN)        ElastoDyn
%       52  RootFyc3    (kN)        ElastoDyn
%       53  RootFzc3    (kN)        ElastoDyn
%       54  RootMxc3    (kN·m)      ElastoDyn
%       55  RootMyc3    (kN·m)      ElastoDyn
%       56  RootMzc3    (kN·m)      ElastoDyn
%       60  Spn1MLxb2   (kN·m)      ElastoDyn
%       61  Spn1MLyb2   (kN·m)      ElastoDyn
%       62  Spn1MLzb2   (kN·m)      ElastoDyn
%       63  Spn1MLxb3   (kN·m)      ElastoDyn
%       64  Spn1MLyb3   (kN·m)      ElastoDyn
%       65  Spn1MLzb3   (kN·m)      ElastoDyn
%       84  TwHt1MLxt   (kN·m)      ElastoDyn
%       85  TwHt1MLyt   (kN·m)      ElastoDyn
%       86  TwHt1MLzt   (kN·m)      ElastoDyn

%% 3) AeroDyn
% figure(31)
% plot(Time,RtAeroFxh); hold on
% plot(Time,RtAeroFyh); hold on
% plot(Time,RtAeroFzh); hold off
% legend('x','y','z')
% title('Total rotor aerodynamic load in the hub coordinate system [N]'); xlabel('Time [s]')
% 
% avRtAeroFxh = mean(RtAeroFxh); 
% avRtAeroFyh = mean(RtAeroFyh); 
% avRtAeroFzh = mean(RtAeroFzh);  
% fprintf('\n Average total rotor aerodynamic force:\n x: %f [N] \n y: %f [N] \n z: %f [N] \n',avRtAeroFxh,avRtAeroFyh,avRtAeroFzh);
% 
% figure(32)
% plot(Time,RtAeroMxh); hold on
% plot(Time,RtAeroMyh); hold on
% plot(Time,RtAeroMzh); hold off
% legend('x','y','z')
% title('Total rotor aerodynamic load in the hub coordinate system [Nm]'); xlabel('Time [s]')
% 
% avRtAeroMxh = mean(RtAeroMxh); 
% avRtAeroMyh = mean(RtAeroMyh); 
% avRtAeroMzh = mean(RtAeroMzh);  
% fprintf('\n Average total rotor aerodynamic moment:\n x: %f [Nm] \n y: %f [Nm] \n z: %f [Nm] \n',avRtAeroMxh,avRtAeroMyh,avRtAeroMzh);

figure(33)
plot(Time,RtArea);
title('Rotor swept area [m^2]'); xlabel('Time [s]');

% Computed but not plotted
%       88  B1N3Clrnc   (m)         AeroDyn
%       89  B2N3Clrnc   (m)         AeroDyn
%       90  B3N3Clrnc   (m)         AeroDyn

%% 4) ServoDyn
figure(41)
subplot(2,1,1)
plot(Time,GenPwr);
%legend('Gen. power [kW]')
title('Gen. power [kW]'); xlabel('Time [s]')
subplot(2,1,2)
plot(Time,GenTq);
%legend('Gen. torque [kN*m]')
title('Gen. torque [kN*m]'); xlabel('Time [s]')

figure(411)
%plot(Time,GenPwr); hold on
plot(Time,GenTq); hold on
plot(Time,GenSpeed*2*pi/60); hold off
legend('Torque','Rot. speed') %legend('Power','Torque','Rot. speed')

avGenPwr = mean(GenPwr); 
avGenTq = mean(GenTq); 
avGenSpeed = mean(GenSpeed);  
fprintf('\n Power: %f [kW] \n Torque: %f [k*Nm] \n Generator speed: %f [rpm] \n',avGenPwr,avGenTq,avGenSpeed);

%% 5) HydroDyn
if strcmp(CASE,'ON')
    figure(51)
    plot(Time,Wave1Elev);
    title('Wave elevation in (0,0) [m]'); xlabel('Time [s]')
end

%% 6) SubDyn

% Node Forces and Moments
% MαNβ, refers to node β of member α, where α is a number in the range [1,9]
% and corresponds to row α in the MEMBER OUTPUT LIST table and β is a
% number in the range [1,9] and corresponds to node β in the NodeCnt list of that table entry

% figure(61)
% subplot(2,1,1)
% plot(Time,M2N1MKxe); hold on
% plot(Time,M2N1MKye); hold off
% legend('x','y')
% title('Node forces in 2-1 [Nm]'); xlabel('Time [s]')
% subplot(2,1,2)
% plot(Time,M1N1MKxe); hold on
% plot(Time,M1N1MKye); hold off
% legend('x','y')
% title('Node moments in 1-1 [Nm]'); xlabel('Time [s]')
%       
% % Base reactions: fore-aft shear, side-to-side shear, side-to-side moment, fore-aft moment
% % Total base reaction forces and moments at the (0.,0.,-WtrDpth) location in SS coordinate system
 
% figure(62)
% subplot(2,1,1)
% plot(Time,ReactFXss); hold on
% plot(Time,ReactFYss); hold on
% plot(Time,ReactFZss); hold off
% legend('fore-aft shear','side-to-side shear','z')
% title('Base and Interface Reaction Loads [N]'); xlabel('Time [s]')
% subplot(2,1,2)
% plot(Time,ReactMXss); hold on
% plot(Time,ReactMYss); hold on
% plot(Time,ReactMZss); hold off
% legend('fore-aft shear','side-to-side shear','z')
% title('Base and Interface Reaction Loads [Nm]'); xlabel('Time [s]')

%% MAP++

% Computed but not plotted
%       94  T[1]        [N]         MAP++
%       95  T_a[1]      [N]         MAP++
%       96  T[2]        [N]         MAP++
%       97  T_a[2]      [N]         MAP++
%       98  T[3]        [N]         MAP++
%       99  T_a[3]      [N]         MAP++

%% MoorDyn

% Computed but not plotted
%       42  FAIRTEN1    (N)         MoorDyn
%       43  FAIRTEN2    (N)         MoorDyn
%       44  FAIRTEN3    (N)         MoorDyn
%       45  ANCHTEN1    (N)         MoorDyn
%       46  ANCHTEN2    (N)         MoorDyn
%       47  ANCHTEN3    (N)         MoorDyn

%% Signal spectrum analysis

% examples
spectrumPlot(Wave1Elev,Time)
spectrumPlot(Wind1VelX,Time)
spectrumPlot(Wind1VelY,Time)
spectrumPlot(Wind1VelZ,Time)
spectrumPlot(PtfmSurge,Time)
spectrumPlot(PtfmSway,Time)
spectrumPlot(PtfmHeave,Time)

