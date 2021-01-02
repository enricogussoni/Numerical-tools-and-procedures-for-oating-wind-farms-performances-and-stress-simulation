%% Post-processing
% Working case 1

close all
clear all
clc

%%%%% PAY ATTENTION IN LOADING THE CORRECT WORKSPACE %%%%%
load workSpaceWC1_3.mat

%% 2) ElastoDyn output
figure(2101)
plot(Time,OoPDefl1); %hold on
%plot(Time,IPDefl1); hold off
%legend('Out-of-plane','In-plane')
title('Blade 1 tip deflection [m]'); xlabel('Time [s]')

figure(230)
subplot(2,1,1)
plot(Time,RotSpeed);
legend('RotSpeed')
title('Rotor speed [rpm]'); xlabel('Time [s]')
subplot(2,1,2)
plot(Time,GenSpeed);
legend('GenSpeed')
title('Generator speed [rpm]'); xlabel('Time [s]')

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
title('Blade 1 moment at the blade root [kN]'); xlabel('Time [s]')

avRootMxc1 = mean(RootMxc1); 
avRootMyc1 = mean(RootMyc1); 
avRootMzc1 = mean(RootMzc1); 
fprintf('\n Average blade 1 moment at the blade root:\n x: %f [kN] \n y: %f [kN] \n z: %f [kN] \n',avRootMxc1,avRootMyc1,avRootMzc1);

figure(280)
plot(Time,RotTorq);
title('Rotor torque [kN*m]'); xlabel('Time [s]')

avRotTorq = mean(RotTorq);
fprintf('\n Average rotor torque: %f [kN*m] \n',avRotTorq);

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

figure(295)
plot(Time,TTDspFA); hold on
plot(Time,TTDspSS); hold off
legend('fore-aft','side-to-side')
title('Tower-top / yaw bearing (translational) deflection [m]'); xlabel('Time [s]')

figure(298)
plot(Time,TwrBsMxt); hold on
plot(Time,TwrBsMyt); hold on
plot(Time,TwrBsMzt); hold off
legend('fore-aft','side-to-side','axial')
title('Tower base moment [kN*m]'); xlabel('Time [s]')


%% Signal spectrum analysis

% examples
PSDloglog(PtfmSurge,Time)
PSDloglog(PtfmSway,Time)
PSDloglog(PtfmHeave,Time)
PSDloglog(PtfmRoll,Time)
PSDloglog(PtfmPitch,Time)
PSDloglog(PtfmYaw,Time)
PSDloglog(OoPDefl1,Time)
PSDloglog(RootFxc1,Time)
PSDloglog(TwrBsMyt,Time)
PSDloglog(TTDspFA,Time)
PSDloglog(LSSGagMya,Time)
PSDloglog(LSSGagMza,Time)
PSDloglog(RotTorq,Time)
