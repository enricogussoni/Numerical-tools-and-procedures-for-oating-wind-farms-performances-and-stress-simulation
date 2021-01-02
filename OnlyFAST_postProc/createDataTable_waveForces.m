%% Import data from text file.
% Script for importing data from the following text file:
%
%    C:\Users\Enrico\GUSS\POLIMI\TESI\OpenFAST_HydroDyn\variable_WaveDir\0deg_waveForces\Test25.out
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2019/03/16 16:51:38

%% Initialize variables.
%filename = 'C:\Users\Enrico\GUSS\POLIMI\TESI\OpenFAST_HydroDyn\variable_WaveDir\0deg_waveForces\Test25.out';
delimiter = '\t';
startRow = 6;
endRow = 1206;

%% Format for each line of text:
%   column1: double (%f)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
%   column5: double (%f)
%	column6: double (%f)
%   column7: double (%f)
%	column8: double (%f)
%   column9: double (%f)
%	column10: double (%f)
%   column11: double (%f)
%	column12: double (%f)
%   column13: double (%f)
%	column14: double (%f)
%   column15: double (%f)
%	column16: double (%f)
%   column17: double (%f)
%	column18: double (%f)
%   column19: double (%f)
%	column20: double (%f)
%   column21: double (%f)
%	column22: double (%f)
%   column23: double (%f)
%	column24: double (%f)
%   column25: double (%f)
%	column26: double (%f)
%   column27: double (%f)
%	column28: double (%f)
%   column29: double (%f)
%	column30: double (%f)
%   column31: double (%f)
%	column32: double (%f)
%   column33: double (%f)
%	column34: double (%f)
%   column35: double (%f)
%	column36: double (%f)
%   column37: double (%f)
%	column38: double (%f)
%   column39: double (%f)
%	column40: double (%f)
%   column41: double (%f)
%	column42: double (%f)
%   column43: double (%f)
%	column44: double (%f)
%   column45: double (%f)
%	column46: double (%f)
%   column47: double (%f)
%	column48: double (%f)
%   column49: double (%f)
%	column50: double (%f)
%   column51: double (%f)
%	column52: double (%f)
%   column53: double (%f)
%	column54: double (%f)
%   column55: double (%f)
%	column56: double (%f)
%   column57: double (%f)
%	column58: double (%f)
%   column59: double (%f)
%	column60: double (%f)
%   column61: double (%f)
%	column62: double (%f)
%   column63: double (%f)
%	column64: double (%f)
%   column65: double (%f)
%	column66: double (%f)
%   column67: double (%f)
%	column68: double (%f)
%   column69: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
textscan(fileID, '%[^\n\r]', startRow-1, 'WhiteSpace', '', 'ReturnOnError', false);
dataArray = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', delimiter, 'TextType', 'string', 'ReturnOnError', false, 'EndOfLine', '\r\n');

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Create output variable
dataTable = table(dataArray{1:end-1}, 'VariableNames', {'Time','Azimuth','RotSpeed','GenSpeed','OoPDefl1','IPDefl1','TwstDefl1','BldPitch1','TTDspFA','TTDspSS','TTDspTwst','PtfmSurge','PtfmSway','PtfmHeave','PtfmRoll','PtfmPitch','PtfmYaw','RootFxc1','RootFyc1','RootFzc1','RootMxc1','RootMyc1','RootMzc1','RotTorq','LSSGagMya','LSSGagMza','YawBrFxp','YawBrFyp','YawBrFzp','YawBrMxp','YawBrMyp','YawBrMzp','TwrBsFxt','TwrBsFyt','TwrBsFzt','TwrBsMxt','TwrBsMyt','TwrBsMzt','Wave1Elev','HydroFxi','HydroFyi','HydroFzi','HydroMxi','HydroMyi','HydroMzi','WavesFxi','WavesFyi','WavesFzi','WavesMxi','WavesMyi','WavesMzi','WavesF1xi','WavesF1yi','WavesF1zi','WavesM1xi','WavesM1yi','WavesM1zi','HdrStcFxi','HdrStcFyi','HdrStcFzi','HdrStcMxi','HdrStcMyi','HdrStcMzi','FAIRTEN1','FAIRTEN2','FAIRTEN3','ANCHTEN1','ANCHTEN2','ANCHTEN3'});

%% Clear temporary variables
clearvars delimiter startRow endRow formatSpec fileID dataArray ans;