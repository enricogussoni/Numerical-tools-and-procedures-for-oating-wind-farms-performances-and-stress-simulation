%% Test script to run FAST cases from Matlab
%% Test on variable_WaveDir

clear all
% close all
% clc

% Example for Windows:
% [status, result] = system(['"C:\Users\Enrico\GUSS\POLIMI\TESI\FAST_runFiles\FAST_x64d.exe" "C:\Users\Enrico\GUSS\POLIMI\TESI\OpenFAST_HydroDyn\WorkingCase1.3\Test25.fst"'],'-echo');
% Example with directory name from outside:
%
% n=0;
% z=num2str(n);
% [status, result] = system(['"C:\Users\Enrico\GUSS\POLIMI\TESI\FAST_runFiles\FAST_x64d.exe" "C:\Users\Enrico\GUSS\POLIMI\TESI\OpenFAST_HydroDyn\variable_WaveDir\' z 'deg\Test25.fst"'],'-echo');

fastDIR = 'C:\Users\Enrico\GUSS\POLIMI\TESI\FAST_runFiles\FAST_x64d.exe ';        % Mind the space at the end!
mainDir = 'C:\Users\Enrico\GUSS\POLIMI\TESI\OpenFAST_HydroDyn\variable_WaveDir\'; % Folder woth sub-cases
nameFastInFile = 'Test25.fst';  % It must be the same fo all the cases or this instruction has to be repeated in the "for" cycle.
nameFastOutFile = 'Test25.out'; % It must be the same fo all the cases or this instruction has to be repeated in the "for" cycle.
system(['cd ' pwd]);            % To be ready for 'system' command inside the 'for' loop.

FAST_run = 'off';                % When on 'on' it run FAST simulation. Thisi will overwrite already existing FAST outputs if not renamed. Put it on 'off' to have just the post-process or plots.
Matlab_pp = 'on';                % When on 'on' it run Matlab post-process. Thisi will overwrite already existing Matlab outputs if not renamed. Put it on 'off' to have just FAST run or plots.
makePlots = 'off';               % When on 'on' it run Matlab plots. Thisi will overwrite already existing Matlab figures if not renamed. Put it on 'off' to have just FAST run or Matlab post-processing.

fprintf('FAST_run = %s \n Matlab_pp = %s \n makePlots = %s \n',FAST_run,Matlab_pp,makePlots);

% timeHistoriesStr= struct('heave',[],'pitch',[],'roll',[],'surge',[],'sway',[],'yaw',[]);
% results = struct('case',[],'timeHistories',timeHistoriesStr,'fft',[],'spectrum',[],'psd',[],'rao',[]);

matlabOutput = struct('timeHistories',[],'fft',[],'spectrum',[],'psd',[],'rao',[]);
dofs = struct('heave',matlabOutput,'pitch',matlabOutput,'roll',matlabOutput,'surge',matlabOutput,'sway',matlabOutput,'yaw',matlabOutput);
results = struct('waveDir',[],'dofs',dofs);

%% Computation
% Pay attention on how folders for the different cases have been named: it
% must be possible for the "for" cycle to switch among them.

count = 1;
deltaDeg = 30; % [°]  wave direction variation between each case

for deg = 0:deltaDeg:180
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
       save WS -regexp ^(?!(FAST_run|Matlab_pp|makePlots)$). % Saves the actual workspace
       system(['move WS.mat ' directory]); % Moves the actual workspace to the folder of the specific case
       
       % Wave and fft parameters (put here for generality of the script)
       N = length(Time);
       dt = Time(2)-Time(1); T = N*dt;
       fsamp = 1/dt; df = 1/T;
       freq = 0:df:df*N/2;
       [fft_wave , freqW] = fft_norm(Wave1Elev,fsamp); 
       wave_spectrum = abs(fft_wave); % vector of amplitude(freq)

       results(count).waveDir = deg;
       createResultStruct_variableWaveDir; % Evaluates fft, spectrum, PSD and RAO for all 6 platform DoFs
       fprintf('Case %s Matlab post-processing finished \n',g); 
    end
    
%     % Plots
%     if strcmp(makePlots,'on')
%        fprintf('Non hai ancora fatto un comando per i grafici, mona');
%     end
    
    count = count+1;
end


