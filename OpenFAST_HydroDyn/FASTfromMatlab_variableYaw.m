%% Test script to run FAST cases from Matlab
%% Test on variable_Yaw

% clear all
% close all
% clc

% Example for Windows:
% [status, result] = system(['"C:\Users\Enrico\GUSS\POLIMI\TESI\FAST_runFiles\FAST_x64d.exe" "C:\Users\Enrico\GUSS\POLIMI\TESI\OpenFAST_HydroDyn\WorkingCase1.3\Test25.fst"'],'-echo');
% Example with directory name from outside:
%
% n=0;
% z=num2str(n);
% [status, result] = system(['"C:\Users\Enrico\GUSS\POLIMI\TESI\FAST_runFiles\FAST_x64d.exe" "C:\Users\Enrico\GUSS\POLIMI\TESI\OpenFAST_HydroDyn\variable_Yaw\' z 'deg\Test25.fst"'],'-echo');

fastDIR = 'C:\Users\Enrico\GUSS\POLIMI\TESI\FAST_runFiles\FAST_x64d.exe ';        % Mind the space at the end!
mainDir = 'C:\Users\Enrico\GUSS\POLIMI\TESI\OpenFAST_HydroDyn\variable_Yaw\'; % Folder woth sub-cases
%savePicsDir = 'C:\Users\Enrico\Dropbox\TESI\TESTO\pic\hydro\waveMod2\yaw2'; % Directory where to save pics
savePicsDir = mainDir; % Directory where to save pics
givenFormat = 'fig'; % 'eps' or 'jpg' or 'png' or 'pdf' or 'svg', otherwise saves figures as .fig
nameFastInFile = 'Test25.fst';  % It must be the same fo all the cases or this instruction has to be repeated in the "for" cycle.
nameFastOutFile = 'Test25.out'; % It must be the same fo all the cases or this instruction has to be repeated in the "for" cycle.
system(['cd ' pwd]);            % To be ready for 'system' command inside the 'for' loop.

% FAST_run = 'off';               % When on 'on' it run FAST simulation. Thisi will overwrite already existing FAST outputs if not renamed. Put it on 'off' to have just the post-process or plots.
FAST_run = 'off';                % When on 'on' it run FAST simulation. Thisi will overwrite already existing FAST outputs if not renamed. Put it on 'off' to have just the post-process or plots.
% Matlab_pp = 'off';              % When on 'on' it run Matlab post-process. Thisi will overwrite already existing Matlab outputs if not renamed. Put it on 'off' to have just FAST run or plots.
Matlab_pp = 'on';               % When on 'on' it run Matlab post-process. Thisi will overwrite already existing Matlab outputs if not renamed. Put it on 'off' to have just FAST run or plots.
% makePlots = 'off';              % When on 'on' it run Matlab plots. Thisi will overwrite already existing Matlab figures if not renamed. Put it on 'off' to have just FAST run or Matlab post-processing.
makePlots = 'on';               % When on 'on' it run Matlab plots. Thisi will overwrite already existing Matlab figures if not renamed. Put it on 'off' to have just FAST run or Matlab post-processing.

fprintf('FAST_run = %s \n Matlab_pp = %s \n makePlots = %s \n',FAST_run,Matlab_pp,makePlots);

% timeHistoriesStr= struct('heave',[],'pitch',[],'roll',[],'surge',[],'sway',[],'yaw',[]);
% results = struct('case',[],'timeHistories',timeHistoriesStr,'fft',[],'spectrum',[],'psd',[],'rao',[]);

matlabOutput = struct('timeHistories',[],'fft',[],'spectrum',[],'psd',[],'rao',[]); % timeHistories is not implemented but can be uset to memorize other time histories.
dofs = struct('heave',matlabOutput,'pitch',matlabOutput,'roll',matlabOutput,'surge',matlabOutput,'sway',matlabOutput,'yaw',matlabOutput);
results = struct('waveDir',[],'dofs',dofs);

%% Computation
% Pay attention on how folders for the different cases have been named: it
% must be possible for the "for" cycle to switch among them.

minDir = 0; % [°] First case
maxDir = 180; % [°] Last case
deltaDeg = 30; % [°]  yaw direction variation between each case
dirVect = minDir:deltaDeg:maxDir; % Vector of directions
nDir = length(dirVect); % Number of cases

count = 1;
for deg = minDir:deltaDeg:maxDir
    g=num2str(deg);
    directory = [mainDir g 'deg\']; % Case directory containing the requested .fst file (needed for runCommandList)
        
    % FAST run
    if strcmp(FAST_run,'on')
        fprintf('Running the FAST case %s \n',g);
        system([fastDIR directory nameFastInFile],'-echo'); % Executes FAST_x64 as from shell. The actual directory doesn't matter.
        fprintf('Case %s FAST run finished \n',g);
    end
    
    % Matlab computation (for spectral analysis)
    if strcmp(Matlab_pp,'on')
       fprintf('Running Matlab post-processing for case %s \n',g);
       runCommandList;
       
       % Yaw and fft parameters (put here for generality of the script)
       N = length(Time);
       dt = Time(2)-Time(1); T = N*dt;
       fsamp = 1/dt; df = 1/T;
       freq = 0:df:df*N/2;
       [fft_wave , freqW] = fft_norm(Wave1Elev,fsamp); 
       wave_spectrum = abs(fft_wave); % vector of amplitude(freq)

       results(count).waveDir = deg;
       createResultStruct; % Evaluates fft, spectrum, PSD and RAO for all 6 platform DoFs
       fprintf('Case %s Matlab post-processing finished \n',g); 
       
       save WS -regexp ^(?!(FAST_run|Matlab_pp|makePlots)$). % Saves the actual workspace
       system(['move WS.mat ' directory]); % Moves the actual workspace to the folder of the specific case
    end
    
    count = count+1;
end

% Acces to 'results' struct: results(n).dofs.nameOfTheDoF.ect
% n = index of the yaw direction
% nameOfTheDoF: heave, pitch, roll, surge, sway, yaw
% etc = fft, spectrum, psd, rao, timeHistory,


%% Plots

lineWidth = 1; % Linewidth in plots

% Plot example:
% figure(1)
% for pl = 1:nDir
% plot(Time,results(pl).dofs.heave.timeHistory);hold on
% %legendNames(pl) = num2str(dirVect(pl));
% end
% hold off;
% title('Heave time history'); xlabel('Time [s]'); ylabel('Heave [m]');
% %legend(legendNames);


close all
NameList = {'HeaveRAO', 'PitchRAO', 'RollRAO','SurgeRAO','SwayRAO','YawRAO'};

shortFreqPlot = 'on'; % To plot only low frequencies (TBN: in this version of the code thi is the limit for bot DoFs and wave-forces plots)
maximumFrequency = 1; % Upper frequency limit in the plot
if strcmp(shortFreqPlot,'on')
    freqOld=freq;
    freq=freq(freq<maximumFrequency);
    nz=length(freq);
else
    nz=length(freq);
end

% 2D plots

if strcmp(makePlots,'on')
    
    figure(2)
    for pl = 1:nDir
        plot(freq,log10(results(pl).dofs.heave.rao(1:nz)),'LineWidth',lineWidth); hold on
    end
    hold off;
    title(NameList{1}); xlabel('Frequency [Hz]'); %ylabel('Heave [m]');
    legend('0','30','60','90','120','150','180'); grid on
    figureName = NameList{1}; saveFigGiveFormat; % Save the figure
    

    figure(3)
    for pl = 1:nDir
        plot(freq,log10(results(pl).dofs.pitch.rao(1:nz)),'LineWidth',lineWidth); hold on
    end
    hold off;
    title(NameList{2}); xlabel('Direction [°]'); ylabel('Frequency [Hz]');
    legend('0','30','60','90','120','150','180'); grid on
    figureName = NameList{2}; saveFigGiveFormat; % Save the figure
    
    figure(4)
    for pl = 1:nDir
        plot(freq,log10(results(pl).dofs.roll.rao(1:nz)),'LineWidth',lineWidth); hold on
    end
    hold off;
    title(NameList{3}); xlabel('Frequency [Hz]'); %ylabel('Roll [m]');
    legend('0','30','60','90','120','150','180'); grid on
    figureName = NameList{3}; saveFigGiveFormat; % Save the figure
    
    figure(5)
    for pl = 1:nDir
        plot(freq,log10(results(pl).dofs.surge.rao(1:nz)),'LineWidth',lineWidth); hold on
    end
    hold off;
    title(NameList{4}); xlabel('Frequency [Hz]'); %ylabel('Surge [m]');
    legend('0','30','60','90','120','150','180'); grid on
    figureName = NameList{4}; saveFigGiveFormat; % Save the figure

    figure(6)
    for pl = 1:nDir
        plot(freq,log10(results(pl).dofs.sway.rao(1:nz)),'LineWidth',lineWidth); hold on
    end
    hold off;
    title(NameList{5}); xlabel('Frequency [Hz]'); %ylabel('Sway [m]');
    legend('0','30','60','90','120','150','180'); grid on
    figureName = NameList{5}; saveFigGiveFormat; % Save the figure

    figure(7)
    for pl = 1:nDir
        plot(freq,log10(results(pl).dofs.yaw.rao(1:nz)),'LineWidth',lineWidth); hold on
    end
    hold off;
    title(NameList{6}); xlabel('Frequency [Hz]'); %ylabel('Yaw [m]');
    legend('0','30','60','90','120','150','180'); grid on
    figureName = NameList{6}; saveFigGiveFormat; % Save the figure

end

close all
system(['move *RAO* ' savePicsDir]); % Moves pictures into main folder
clear figureName;

% 3D plots

% Example
% for pl3d = 1:nDir
%     plot3(dirVect(pl3d)*ones(1,length(freq)),freq,log10(results(pl3d).dofs.heave.rao); hold on
%     grid on
% end
% hold off

if strcmp(makePlots,'on')
    
    figure(2)
    for pl3d = 1:nDir
        plot3(dirVect(pl3d)*ones(1,length(freq)),freq,log10(results(pl3d).dofs.heave.rao(1:nz)),'LineWidth',lineWidth); hold on
    end
    hold off;
    title(NameList{1}); xlabel('Direction [°]'); ylabel('Frequency [Hz]');
    legend('0','30','60','90','120','150','180'); grid on
    figureName = [NameList{1} ' 3D']; saveFigGiveFormat; % Save the figure
    

    figure(3)
    for pl3d = 1:nDir
        plot3(dirVect(pl3d)*ones(1,length(freq)),freq,log10(results(pl3d).dofs.pitch.rao(1:nz)),'LineWidth',lineWidth); hold on
    end
    hold off;
    title(NameList{2}); xlabel('Direction [°]'); ylabel('Frequency [Hz]');
    legend('0','30','60','90','120','150','180'); grid on
    figureName = [NameList{2} ' 3D']; saveFigGiveFormat; % Save the figure
    
    figure(4)
    for pl3d = 1:nDir
        plot3(dirVect(pl3d)*ones(1,length(freq)),freq,log10(results(pl3d).dofs.roll.rao(1:nz)),'LineWidth',lineWidth); hold on
    end
    hold off;
    title(NameList{3}); xlabel('Direction [°]'); ylabel('Frequency [Hz]');
    legend('0','30','60','90','120','150','180'); grid on
    figureName = [NameList{3} ' 3D']; saveFigGiveFormat; % Save the figure
    
    figure(5)
    for pl3d = 1:nDir
        plot3(dirVect(pl3d)*ones(1,length(freq)),freq,log10(results(pl3d).dofs.surge.rao(1:nz)),'LineWidth',lineWidth); hold on
    end
    hold off;
    title(NameList{4});xlabel('Direction [°]'); ylabel('Frequency [Hz]');
    legend('0','30','60','90','120','150','180'); grid on
    figureName = [NameList{4} ' 3D']; saveFigGiveFormat; % Save the figure

    figure(6)
    for pl3d = 1:nDir
        plot3(dirVect(pl3d)*ones(1,length(freq)),freq,log10(results(pl3d).dofs.sway.rao(1:nz)),'LineWidth',lineWidth); hold on
    end
    hold off;
    title(NameList{5}); xlabel('Direction [°]'); ylabel('Frequency [Hz]');
    legend('0','30','60','90','120','150','180'); grid on
    figureName = [NameList{5} ' 3D']; saveFigGiveFormat; % Save the figure

    figure(7)
    for pl3d = 1:nDir
        plot3(dirVect(pl3d)*ones(1,length(freq)),freq,log10(results(pl3d).dofs.yaw.rao(1:nz)),'LineWidth',lineWidth); hold on
    end
    hold off;
    title(NameList{6}); xlabel('Direction [°]'); ylabel('Frequency [Hz]');
    legend('0','30','60','90','120','150','180'); grid on
    figureName = [NameList{6} ' 3D']; saveFigGiveFormat; % Save the figure

end

close all
system(['move *RAO* ' savePicsDir]); % Moves pictures into main folder
