%% Wave Forces analysis

% REQUIRES FASTfromMatlab run
% TBN: this script have to be adapted to the output requested at HydroDyn
% from case to case. This can be done trough the HydroDyn.dat file or
% trough the automatic importing script made by Matlab (see createData
% scripts for example).

% Analized quantities:
% "WavesF1xi" - First-order wave-excitation loads from diffraction at the WRP [N] and [Nm]
% "WavesF1yi"
% "WavesF1zi"
% "WavesM1xi"
% "WavesM1xi"
% "WavesM1xi"
% "HydroFxi" - Total integrated hydrodynamic loads from both potential flow and strip theory at the WRP [N] and [Nm]
% "HydroFyi"
% "HydroFzi"
% "HydroMxi"
% "HydroMyi"
% "HydroMzi"
% "WavesFxi" - Total (first- plus second-order) wave-excitation loads from diffraction at the WRP [N] and [Nm]
% "WavesFyi"
% "WavesFzi"
% "WavesMxi"
% "WavesMyi"
% "WavesMzi"
% "HdrStcFxi" - Hydrostatic loads at the WRP [N] and [Nm]
% "HdrStcFyi"
% "HdrStcFzi"
% "HdrStcMxi"
% "HdrStcMyi"
% "HdrStcMzi"

%% Data pre-process

wFvariables = [
"Wave1Elev"
"WavesF1xi"
"WavesF1yi"
"WavesF1zi"
"WavesM1xi"
"WavesM1yi"
"WavesM1zi"
"HydroFxi"
"HydroFyi"
"HydroFzi"
"HydroMxi"
"HydroMyi"
"HydroMzi"
"WavesFxi"
"WavesFyi"
"WavesFzi"
"WavesMxi"
"WavesMyi"
"WavesMzi"
"HdrStcFxi"
"HdrStcFyi"
"HdrStcFzi"
"HdrStcMxi"
"HdrStcMyi"
"HdrStcMzi"
];

nVariables = length(wFvariables);
waveForcesMatrix = zeros(length(Time),nVariables);

for nv = 1:nVariables
    
   waveForcesMatrix(:,nv)=eval(wFvariables(nv));                            % Matrix of time histories
    
end

waveForcesTable = array2table(waveForcesMatrix);                            % Table of time histories
waveForcesTable.Properties.VariableNames = cellstr(wFvariables);            % Names are added at the table
% oldTable=waveForcesTable;                                                   % For safety comparison
waveForcesTable = checkAndCorrectTable(waveForcesTable);                    % Removes columns of zeroes (with the current function it is possible that some columns are undetected)
waveForcesTable = checkAndCorrectTable(waveForcesTable);                    % With a second run possibilities of undetected colums are discarded
wFvariables = waveForcesTable.Properties.VariableNames;                     % The vector of variable names has to be updated
nVariables = length(wFvariables);                                           % Update nVariables

%% Time histories

if strcmp(makePlots,'on') % makePlots is defined in FASTfromMatlab script

    savePlots = 'on'; % Write somwthing different from "on" to just visualise results
    format = 'png';
    linewidth = 2;

    for nf = 1:nVariables

       figure(nf)
       plot(Time,eval(char(wFvariables(nf))),'LineWidth',linewidth);
       xlabel('Tine [s]'); ylabel(wFvariables(nf));
       title(wFvariables(nf));

       if strcmp(savePlots,'on')
           figureFileName = string(strcat(wFvariables(nf), '_timeHistory'));
           switch format
                case {'eps'}
                    print(figureFileName,'-depsc'); % saves in ".eps" format
                case {'jpg'}
                    print(figureFileName,'-djpeg'); % saves in ".jpg" format
                case {'png'}
                    print(figureFileName,'-dpng');  % saves in ".png" format
                case {'pdf'}
                    print(figureFileName,'-dpdf');  % saves in ".pdf" format
                case {'svg'}
                    print(figureFileName,'-dsvg');  % saves in ".svg" format
                otherwise
                    savefig(figureFileName);        % saves in ".fig" format
           end
           system(strcat('move',{' '}, figureFileName, '.', format, {' '}, directory)); % Moves the actual workspace to the folder of the specific case
           close
       end

    end
end

%% Spectral analysis

sl = length(fft_norm(table2array(waveForcesTable(:,1)),fsamp));             % Sample to determine the length of the spectrum vector

% FFT
waveForcesFFTMatrix = zeros(sl,size(waveForcesTable,2));
waveForcesFFTTable = array2table(waveForcesFFTMatrix);
waveForcesFFTTable.Properties.VariableNames = cellstr(wFvariables);

for nsp = 1:size(waveForcesTable,2)
    
    waveForcesFFTTable(:,nsp) = array2table(fft_norm(table2array(waveForcesTable(:,nsp)),fsamp));     % 'fsamp' is defined in FASTfromMatlab script
    
end

% Spectra
waveForcesSpectrumMatrix = zeros(sl,size(waveForcesTable,2));
waveForcesSpectrumTable = array2table(waveForcesSpectrumMatrix);
waveForcesSpectrumTable.Properties.VariableNames = cellstr(wFvariables);

for nsp = 1:size(waveForcesTable,2)
    
    waveForcesSpectrumTable(:,nsp) = array2table(abs(table2array(waveForcesFFTTable(:,nsp))));
    
end

% Power spectral density
waveForcesPSDMatrix = zeros(sl,size(waveForcesTable,2));
waveForcesPSDTable = array2table(waveForcesPSDMatrix);
waveForcesPSDTable.Properties.VariableNames = cellstr(wFvariables);

for nsp = 1:size(waveForcesTable,2)
    
    waveForcesPSDTable(:,nsp) = array2table(PSD(table2array(waveForcesTable(:,nsp)),Time));     % 'Time' is defined in FASTfromMatlab script
    
end

%% Wave forcing structure building

waveForces(count).timeHistory = waveForcesTable;
waveForces(count).fft = waveForcesFFTTable;
waveForces(count).spectra = waveForcesSpectrumTable;
waveForces(count).psd = waveForcesPSDTable;















