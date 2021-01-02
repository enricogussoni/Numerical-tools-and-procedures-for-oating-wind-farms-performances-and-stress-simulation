filename = [directory,nameFastOutFile];                                     % Full file path
fprintf('Creating dataTable \n')
createDataTable;                                                            % Creates a table called "dataTable"
%createDataTable_waveForces                                                  % For cases with waveForces
fprintf('Checking dataTable \n')
dataTable=checkAndCorrectTable(dataTable);                                  % Removes columns of zeroes
%createDataMatix;
dataMatrix = table2array(dataTable);                                        % dataMatrix is overwriten if createDataMatrix is used
fprintf('Creating dataVariables \n')
createDataVariables;                                                        % Creates all data variables
%createDataVariables_waveForces                                              % For cases with waveForces
fprintf('Making spectrumTable \n')
makeSpectrumTable;