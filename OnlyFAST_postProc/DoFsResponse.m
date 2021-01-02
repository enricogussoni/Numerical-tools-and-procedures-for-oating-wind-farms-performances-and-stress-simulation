%% Script to study the freqency response of FAST degrees of freedom (DoFs)
% THIS IS THE MAIN SCRIPT
% Each section is named after the case DoF given ad initial condition
% Ex: Heave -> 10m of heave as initial condition
% Ex: Pitch -> 10° of pitch as initial condition

% clear all
% close all
% clc

%% Case directory
fprintf('Directory: \n');
directory = 'C:\Users\Enrico\GUSS\POLIMI\TESI\OnlyFAST_postProc\DoFs_test\';
fprintf('%s \n',directory);

%% Run options
fprintf('Run options: \n')
makeCalculations = 'off'; %'on' or 'off'
makePlots = 'on'; %'on' or 'off'
semilogyPlots = 'off'; %'on' or 'off'                                      % 'off' options produces linear plots 
% TBN: figures format has to be changed in runPlots script.
% TBN: maximum plotted frequency is assigned in runPlots script.

fprintf('makeCalculations = %s \n makePlots = %s \n semilogyPlots = %s \n',makeCalculations,makePlots,semilogyPlots);

%% Heave
dof = 'heave';
fprintf('\n Starting heave run \n')
nameFastOutFile = 'Test25heave.out';                                       % Name of the FAST .out file (output)
if strcmp(makeCalculations,'on')
    runCommandList
    heaveSpectrumTable = spectrumTable;
    save heaveWS -regexp ^(?!(makeCalculations|makePlots|semilogyPlots)$).
    clearvars -except 'makeCalculations' 'makePlots' 'semilogyPlots' 'directory'
end

if strcmp(makePlots,'on')
   load('heaveWS')
   runPlots
   clearvars -except 'makeCalculations' 'makePlots' 'semilogyPlots' 'directory'
end

%% Pitch
dof = 'pitch';
fprintf('\n Starting pitch run \n')
nameFastOutFile = 'Test25pitch.out';                                       % Name of the FAST .out file (output)
if strcmp(makeCalculations,'on')
    runCommandList
    pitchSpectrumTable = spectrumTable;
    save pitchWS -regexp ^(?!(makeCalculations|makePlots|semilogyPlots)$).
    clearvars -except 'makeCalculations' 'makePlots' 'semilogyPlots' 'directory'
end

if strcmp(makePlots,'on')
   load('pitchWS')
   runPlots
   clearvars -except 'makeCalculations' 'makePlots' 'semilogyPlots' 'directory'
end

%% Roll
dof = 'roll';
fprintf('\n Starting roll run \n')
nameFastOutFile = 'Test25roll.out';                                        % Name of the FAST .out file (output)
if strcmp(makeCalculations,'on')
    runCommandList
    rollSpectrumTable = spectrumTable;
    save rollWS -regexp ^(?!(makeCalculations|makePlots|semilogyPlots)$).
    clearvars -except 'makeCalculations' 'makePlots' 'semilogyPlots' 'directory'
end

if strcmp(makePlots,'on')
   load('rollWS')
   runPlots
   clearvars -except 'makeCalculations' 'makePlots' 'semilogyPlots' 'directory'
end

%% Surge
dof = 'surge';
fprintf('\n Starting surge run \n')
nameFastOutFile = 'Test25surge.out';                                       % Name of the FAST .out file (output)
if strcmp(makeCalculations,'on')
    runCommandList
    surgeSpectrumTable = spectrumTable;
    save surgeWS -regexp ^(?!(makeCalculations|makePlots|semilogyPlots)$).
    clearvars -except 'makeCalculations' 'makePlots' 'semilogyPlots' 'directory'
end

if strcmp(makePlots,'on')
   load('surgeWS')
   runPlots
   clearvars -except 'makeCalculations' 'makePlots' 'semilogyPlots' 'directory'
end

%% Sway
dof = 'sway';
fprintf('\n Starting sway run \n')
nameFastOutFile = 'Test25sway.out';                                        % Name of the FAST .out file (output)
if strcmp(makeCalculations,'on')
    runCommandList
    swaySpectrumTable = spectrumTable;
    save swayWS -regexp ^(?!(makeCalculations|makePlots|semilogyPlots)$).
    clearvars -except 'makeCalculations' 'makePlots' 'semilogyPlots' 'directory'
end

if strcmp(makePlots,'on')
   load('swayWS')
   runPlots
   clearvars -except 'makeCalculations' 'makePlots' 'semilogyPlots' 'directory'
end

%% Yaw
dof = 'yaw';
fprintf('\n Starting yaw run \n')
nameFastOutFile = 'Test25yaw.out';                                         % Name of the FAST .out file (output)
if strcmp(makeCalculations,'on')
    runCommandList
    yawSpectrumTable = spectrumTable;
    save yawWS -regexp ^(?!(makeCalculations|makePlots|semilogyPlots)$).
    clearvars -except 'makeCalculations' 'makePlots' 'semilogyPlots' 'directory'
end

if strcmp(makePlots,'on')
   load('yawWS')
   runPlots
   clearvars -except 'makeCalculations' 'makePlots' 'semilogyPlots' 'directory'
end
