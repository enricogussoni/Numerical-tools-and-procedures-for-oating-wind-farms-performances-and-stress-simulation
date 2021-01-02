%% Test script to better compare PSD of different signals not only grafically 
% but mathematically.
% Basically it maps PSD peaks position in a matrix that has as many colums
% as variables and as many rows as sampled frequencies.

clear all
close all
clc

%% Loading data

nameFastOutFile = 'Test25.out'; % Name of the FAST .out file (output)

createDataTable;     % Creates a table called "data"
createDataMatrix;    % Creates a matrix-tybe variable called "data"
createDataVariables; % Creates all data variables

variableNames = dataTable.Properties.VariableNames; % Vector of variable's names
variableNames = variableNames(2:end);               % Removing "Time"

psd = zeros(ceil(size(dataMatrix,1)/2),size(dataMatrix,2)-1); % Time colum is ignored for spectra
peaksValues = zeros(size(psd));
frequences = zeros(size(psd));
% peaksPositions = zeros(size(psd));

%% Evaluation and comparison

for cc = 2:(size(dataMatrix,2)-1) % 1 = Time (PSD of time doesn't make sense)
     
    [psd(:,cc),frequences(:,cc)] = PSD(dataMatrix(:,cc),Time);         % PSD evaluation (frequences matrix is unnecessary but usefull to check)
    [singleVariablePeaksValues,peaksPositions] = findpeaks(psd(:,cc)); % Values and position of PSD peaks
    peaksValues(peaksPositions,cc) = singleVariablePeaksValues;        % Saves peaks values in their position
        
end

positions = peaksValues>0; % Puts a 1 where there is a peak
freq = frequences(:,2);    % Frequences vector

%% Building of the table

spectrumTable = [array2table(freq) array2table(positions)]; % 1 means that there is a peak for that variable (column) at that frequency
spectrumTable.Properties.VariableNames = ['Freq' variableNames];



