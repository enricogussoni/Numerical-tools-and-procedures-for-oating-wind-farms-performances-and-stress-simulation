%% Test script to better compare PSD of different signals not only grafically 
% but mathematically.
% Basically it maps PSD peaks position in a matrix that has as many colums
% as variables and as many rows as sampled frequencies.

clear all
close all
clc

%% Loading data
% ATTENTION: colums of constant values or with just a different valua at
% time 0 will make an error occur when scaling PSD plots. FAST output
% channels have to be chosed thinking at that. Otherwise only
% "createDataFile has to be used and unvalid colums have to be manually
% removed.

nameFastOutFile = 'Test25.out'; % Name of the FAST .out file (output)


createDataTable;                        % Creates a table called "data"
dataMatrix = table2array(dataTable);   % dataMatrix is overwriten if createDataMatrix is used
%createDataMatrix;                       % Creates a matrix-tybe variable called "data"
createDataVariables;                    % Creates all data variables



variableNames = dataTable.Properties.VariableNames; % Vector of variable's names
variableNames = variableNames(2:end);               % Removing "Time"

psd = zeros(ceil(size(dataMatrix,1)/2),size(dataMatrix,2)-1); % Time colum is ignored for spectra
peaksValues = zeros(size(psd));
frequences = zeros(size(psd));
maxFreqSingleVariable = zeros(size(dataMatrix,2));


%% Evaluation and comparison

filterCoef = 10; % Necessary to ignore peaks that are less than 1/filterCoef of maximum peak
maxFreq = 0;     % Initialization (changed in next "for" cycle)

for cc = 2:(size(dataMatrix,2)-1) % 1 = Time (PSD of time doesn't make sense)
     
    [psd(:,cc),frequences(:,cc)] = PSD(dataMatrix(:,cc),Time);         % PSD evaluation (frequences matrix is unnecessary but usefull to check)
    MaxPSD = max(psd(:,cc));                                                 % Reference value to filter low level peaks
    filteredPSD = psd(:,cc);                                                 % New variable not to overwrite "psd"
    filteredPSD(filteredPSD<(1/filterCoef)*MaxPSD)=0;                      % Filtering of peaks smaller than filterCoef*MaxPSD
    [singleVariablePeaksValues,peaksPositions] = findpeaks(filteredPSD); % Values and position of PSD peaks (high-pass filtered)
    peaksValues(peaksPositions,cc) = singleVariablePeaksValues;        % Saves peaks values in their position
    
    
%     [psd(:,cc),frequences(:,cc)] = PSD(dataMatrix(:,cc),Time);         % PSD evaluation (frequences matrix is unnecessary but usefull to check)
%     [singleVariablePeaksValues,peaksPositions] = findpeaks(psd(:,cc)); % Values and position of PSD peaks
%     peaksValues(peaksPositions,cc) = singleVariablePeaksValues;        % Saves peaks values in their position
%         
    
    Freq = frequences(:,cc);                                           % CHECK: all frequency vectors should be the same
    %maxFreqSingleVariable(cc)=max(Freq(peaksPositions));               % Maximum relevant frequency of the considered variable
    if max(Freq(peaksPositions)) > maxFreq
       maxFreq = max(Freq(peaksPositions));                            % To avoid plotting usless high frequencies
    end
    
end

Positions = peaksValues>0;                % Puts a 1 where there is a peak
whereIsMaxFreq = find(Freq==maxFreq);     % Position of the maximum frequency
positions= Positions(1:whereIsMaxFreq,:); % Shortened peaks matrix
freq = Freq(1:whereIsMaxFreq);            % Shortened frequencies vector

%% Building of the table
% Considering just values for frequency < maxFreq

spectrumTable = [array2table(freq) array2table(positions)];      % 1 means that there is a peak for that variable (column) at that frequency
spectrumTable.Properties.VariableNames = ['Freq' variableNames]; % Names are added at the table

%% Plots

for pp = 2:(size(spectrumTable,2)-1)                           % spectrumTable.1 = frequences
    
    variableName = spectrumTable.Properties.VariableNames(pp); % Name of the variable whose PSD is plotted (cell-type variable)
    
    figure(pp-1)
    %semilogy(freq, psd_short(:,pp));  hold on;
    plot(freq, psd(1:length(freq),pp)); hold on;
    p=find(positions(:,pp)==1);
    plot(freq(p), psd(p,pp),'o'); hold off;
    xlabel('Frequency [Hz]'); ylabel('PSD');
    title([variableName "PSD peaks"]);
    
%     print(string(variableName),'-depsc'); % saves in ".eps" format
%    print(string(variableName),'-djpeg'); % saves in ".jpg" format
%    print(string(variableName),'-dpng');  % saves in ".png" format
%    print(string(variableName),'-dpdf');  % saves in ".pdf" format
%    print(string(variableName),'-dsvg');  % saves in ".svg" format
    close all
    
end

% figure(pp+1)
% for qq = 2:(size(spectrumTable,2)-1)                           % spectrumTable.1 = frequences
%     
%     %semilogy(freq, psd_short(:,pp));  hold on;
%     plot(freq, psd(1:length(freq),qq)/max(psd(1:length(freq),qq))); hold on;
%     p=find(positions(:,qq)==1);
%     plot(freq(p), psd(p,qq),'o'); hold on;
%     
% end
% 
% hold off;
% xlabel('Frequency [Hz]'); ylabel('PSD');
% title('All plots')
% 
% print('All_plots','-depsc');  % saves in ".eps" format
% % print(string(variableName),'-djpeg'); % saves in ".jpg" format
% % print(string(variableName),'-dpng');  % saves in ".png" format
% % print(string(variableName),'-dpdf');  % saves in ".pdf" format
% % print(string(variableName),'-dsvg');  % saves in ".svg" format
% close all
