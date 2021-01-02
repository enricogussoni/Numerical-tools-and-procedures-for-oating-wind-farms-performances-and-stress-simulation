%% Test script to run FAST cases from Matlab
%% Test on variable_WaveDir

% clear all
% close all
% clc

% Example for Windows:
% [status, result] = system(['"C:\Users\Enrico\GUSS\POLIMI\TESI\FAST_runFiles\FAST_x64d.exe" "C:\Users\Enrico\GUSS\POLIMI\TESI\OpenFAST_HydroDyn\WorkingCase1.3\Test25.fst"'],'-echo');
% Example with directory name from outside:
%
% n=0;
% z=num2str(n);
% [status, result] = system(['"C:\Users\Enrico\GUSS\POLIMI\TESI\FAST_runFiles\FAST_x64d.exe" "C:\Users\Enrico\GUSS\POLIMI\TESI\OpenFAST_HydroDyn\variable_WaveDir\' z 'deg\Test25.fst"'],'-echo');

fastDIR = 'C:\Users\Enrico\GUSS\POLIMI\TESI\FAST_runFiles\FAST_x64d.exe '; % Mind the space at the end!
mainDir = 'C:\Users\Enrico\GUSS\POLIMI\TESI\OpenFAST_HydroDyn\variable_WaveDir\'; % Folder woth sub-cases
caseDir = 'deg\'; % Sub-case name (repeated as [n]caseDir where [n] is the considered direction in deg
%savePicsDir = 'C:\Users\Enrico\Dropbox\TESI\TESTO\pic\hydro\waveDir\waveForce'; % Directory where to save pics
savePicsDir = mainDir; % Directory where to save pics
nameFastInFile = 'Test25.fst';  % It must be the same fo all the cases or this instruction has to be repeated in the "for" cycle.
nameFastOutFile = 'Test25.out'; % It must be the same fo all the cases or this instruction has to be repeated in the "for" cycle.
system(['cd ' pwd]);            % To be ready for 'system' command inside the 'for' loop.

FAST_run = 'off';                % When on 'on' it run FAST simulation. Thisi will overwrite already existing FAST outputs if not renamed. Put it on 'off' to have just the post-process or plots.
Matlab_pp = 'on';                % When on 'on' it run Matlab post-process. Thisi will overwrite already existing Matlab outputs if not renamed. Put it on 'off' to have just FAST run or plots.
makePlots = 'on';               % When on 'on' it run Matlab plots. Thisi will overwrite already existing Matlab figures if not renamed. Put it on 'off' to have just FAST run or Matlab post-processing.
    DoFsPlots = 'on';          % To plot results related to platform's 6 DoFs
    waveForcesPlots = 'on';     % To plot results related to waves forcing

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
deltaDeg = 30; % [°]  wave direction variation between each case
dirVect = minDir:deltaDeg:maxDir; % Vector of directions
nDir = length(dirVect); % Number of cases

count = 1;
for deg = minDir:deltaDeg:maxDir
    g=num2str(deg);
    directory = [mainDir g caseDir]; % Case directory containing the requested .fst file (needed for runCommandList)
        
    % FAST run
    if strcmp(FAST_run,'on')
        fprintf('Running the FAST case %s \n',g);
        system([fastDIR directory nameFastInFile],'-echo'); % Executes FAST_x64 as from shell. The actual directory doesn't matter.
        fprintf('Case %s FAST run finished \n',g);
    end
    
    % Matlab computation (for spectral analysis)
    if strcmp(Matlab_pp,'on')
       fprintf('Running Matlab post-processing for case %s \n',g);
       runCommandList; % CHECK which "create" script is used inside (depending on the type of imported ".out" file)
       save WS -regexp ^(?!(FAST_run|Matlab_pp|makePlots)$). % Saves the actual workspace
       system(['move WS.mat ' directory]); % Moves the actual workspace to the folder of the specific case
       
       %% 6 DoFs RAO analysis
       % Wave and fft parameters (put here for generality of the script)
       fprintf('Running Matlab platform DoFs analysis for case %s \n',g);
       N = length(Time);
       dt = Time(2)-Time(1); T = N*dt;
       fsamp = 1/dt; df = 1/T;
       freq = 0:df:df*N/2;
       [fft_wave , freqW] = fft_norm(Wave1Elev,fsamp); 
       wave_spectrum = abs(fft_wave); % vector of amplitude(freq)

% Acces to 'results' struct: results(n).dofs.nameOfTheDoF.ect
% n = index of the wave direction
% nameOfTheDoF: heave, pitch, roll, surge, sway, yaw
% etc = timeHistory, fft, spectrum, psd, rao 
       results(count).waveDir = deg;
       createResultStruct; % Evaluates fft, spectrum, PSD and RAO for all 6 platform DoFs
       fprintf('End of Matlab platform DoFs analysis for case %s \n',g);
       
       %% Wave forces analysis
       fprintf('Running Matlab wave forces analysis for case %s \n',g);
% Acces to 'waveForces' struct: waveForces(n).etc
% n = index of the wave direction
% etc = timeHistory, fft, spectrum, psd (under table format: each column
% correspond to a different variable).
% To check variables: waveForces(1).fft.Properties.VariableNames (example)
       waveForcesAnalysis; % Evaluates fft, spectrum and PSD for HydroDyn outputs
       fprintf('End of Matlab wave forces analysis for case %s \n',g);
       
       fprintf('Case %s Matlab post-processing finished \n',g);
       
    end
    count = count+1;
end


%% 3D Plots
close all
%load(strcat(mainDir,'180', caseDir, 'WS.mat')) % If a specific case ha to be loaded (if Matlab_pp has run and WS has not been cleaned it should not be necessary)

lineWidth = 1; % Linewidth in plots
DoFsNameList = {'HeaveRAO', 'PitchRAO', 'RollRAO','SurgeRAO','SwayRAO','YawRAO'};
% waveForNameList = wFvariables;
givenFormat = 'fig'; % 'eps' or 'jpg' or 'png' or 'pdf' or 'svg', otherwise save as .fig

% nz=length(freq);    % For entire frequency vector
shortFreqPlot = 'on'; % To plot only low frequencies (TBN: in this version of the code thi is the limit for bot DoFs and wave-forces plots)
maximumFrequency = 1; % Upper frequency limit in the plot
if strcmp(shortFreqPlot,'on')
    freqOld=freq;
    freq=freq(freq<maximumFrequency);
    nz=length(freq);
else
    nz=length(freq);
end

if strcmp(makePlots,'on')

    if strcmp(DoFsPlots,'on')

        figure(1)
        for pl3d = 1:nDir
            plot3(dirVect(pl3d)*ones(1,nz),freq,log10(results(pl3d).dofs.heave.rao(1:nz)),'LineWidth',lineWidth); hold on
        end
        hold off;
        title(DoFsNameList{1}); xlabel('Direction [°]'); ylabel('Frequency [Hz]'); zlabel('log RAO');
        legend('0','30','60','90','120','150','180'); grid on
        figureName = [DoFsNameList{1} ' 3D']; saveFigGiveFormat; % Save the figure


        figure(2)
        for pl3d = 1:nDir
            plot3(dirVect(pl3d)*ones(1,nz),freq,log10(results(pl3d).dofs.pitch.rao(1:nz)),'LineWidth',lineWidth); hold on
        end
        hold off;
        title(DoFsNameList{2}); xlabel('Direction [°]'); ylabel('Frequency [Hz]'); zlabel('log RAO');
        legend('0','30','60','90','120','150','180'); grid on
        figureName = [DoFsNameList{2} ' 3D']; saveFigGiveFormat; % Save the figure

        figure(3)
        for pl3d = 1:nDir
            plot3(dirVect(pl3d)*ones(1,nz),freq,log10(results(pl3d).dofs.roll.rao(1:nz)),'LineWidth',lineWidth); hold on
        end
        hold off;
        title(DoFsNameList{3}); xlabel('Direction [°]'); ylabel('Frequency [Hz]'); zlabel('log RAO');
        legend('0','30','60','90','120','150','180'); grid on
        figureName = [DoFsNameList{3} ' 3D']; saveFigGiveFormat; % Save the figure

        figure(4)
        for pl3d = 1:nDir
            plot3(dirVect(pl3d)*ones(1,nz),freq,log10(results(pl3d).dofs.surge.rao(1:nz)),'LineWidth',lineWidth); hold on
        end
        hold off;
        title(DoFsNameList{4}); xlabel('Direction [°]'); ylabel('Frequency [Hz]'); zlabel('log RAO');
        legend('0','30','60','90','120','150','180'); grid on
        figureName = [DoFsNameList{4} ' 3D']; saveFigGiveFormat; % Save the figure

        figure(5)
        for pl3d = 1:nDir
            plot3(dirVect(pl3d)*ones(1,nz),freq,log10(results(pl3d).dofs.sway.rao(1:nz)),'LineWidth',lineWidth); hold on
        end
        hold off;
        title(DoFsNameList{5}); xlabel('Direction [°]'); ylabel('Frequency [Hz]'); zlabel('log RAO');
        legend('0','30','60','90','120','150','180'); grid on
        figureName = [DoFsNameList{5} ' 3D']; saveFigGiveFormat; % Save the figure

        figure(6)
        for pl3d = 1:nDir
            plot3(dirVect(pl3d)*ones(1,nz),freq,log10(results(pl3d).dofs.yaw.rao(1:nz)),'LineWidth',lineWidth); hold on
        end
        hold off;
        title(DoFsNameList{6}); xlabel('Direction [°]'); ylabel('Frequency [Hz]'); zlabel('log RAO');
        legend('0','30','60','90','120','150','180'); grid on
        figureName = [DoFsNameList{6} ' 3D']; saveFigGiveFormat; % Save the figure

        
        close all
        system(['move *RAO* ' savePicsDir]); % Moves pictures into main folder
    
    end
    
    if strcmp(waveForcesPlots,'on')
        for nv = 1:size(waveForces(1).spectra,2)                            % One plot for every variable
            
            figure(100+nv)                                                  % 100 needed not to overwrite prevouos figures while runnin
            for wf3d =1:nDir                                                % Each plot contains data for all the directions
                plot3(dirVect(wf3d)*ones(1,nz),freq,table2array(waveForces(wf3d).spectra(1:nz,nv)),'LineWidth',lineWidth); 
                hold on
            end
            hold off;
            title(wFvariables{nv}); xlabel('Direction [°]'); ylabel('Frequency [Hz]'); zlabel('log RAO'); 
            legend('0','30','60','90','120','150','180'); grid on
            figureName = [wFvariables{nv} ' spectrum']; saveFigGiveFormat;  % Save the figure
            
            system(['move ' figureName {' '} mainDir]); 
        end
        close all
    end

end


