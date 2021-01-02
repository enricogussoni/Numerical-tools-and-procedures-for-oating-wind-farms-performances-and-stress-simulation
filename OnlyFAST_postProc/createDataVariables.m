%% Import data from text file.
% Script for importing data from FAST output file ([name].out).
% The name of the file has to be given as a variable nameFastOutFile in the main script.

%% Initialize variables.
%filename = ['C:\Users\Enrico\GUSS\POLIMI\TESI\OnlyFAST_postProc\provaSpettri\' nameFastOutFile];
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
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';

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

%% Allocate imported array to column variable names
Time = dataArray{:, 1};
Azimuth = dataArray{:, 2};
RotSpeed = dataArray{:, 3};
GenSpeed = dataArray{:, 4};
OoPDefl1 = dataArray{:, 5};
IPDefl1 = dataArray{:, 6};
TwstDefl1 = dataArray{:, 7};
BldPitch1 = dataArray{:, 8};
TTDspFA = dataArray{:, 9};
TTDspSS = dataArray{:, 10};
TTDspTwst = dataArray{:, 11};
PtfmSurge = dataArray{:, 12};
PtfmSway = dataArray{:, 13};
PtfmHeave = dataArray{:, 14};
PtfmRoll = dataArray{:, 15};
PtfmPitch = dataArray{:, 16};
PtfmYaw = dataArray{:, 17};
RootFxc1 = dataArray{:, 18};
RootFyc1 = dataArray{:, 19};
RootFzc1 = dataArray{:, 20};
RootMxc1 = dataArray{:, 21};
RootMyc1 = dataArray{:, 22};
RootMzc1 = dataArray{:, 23};
RotTorq = dataArray{:, 24};
LSSGagMya = dataArray{:, 25};
LSSGagMza = dataArray{:, 26};
YawBrFxp = dataArray{:, 27};
YawBrFyp = dataArray{:, 28};
YawBrFzp = dataArray{:, 29};
YawBrMxp = dataArray{:, 30};
YawBrMyp = dataArray{:, 31};
YawBrMzp = dataArray{:, 32};
TwrBsFxt = dataArray{:, 33};
TwrBsFyt = dataArray{:, 34};
TwrBsFzt = dataArray{:, 35};
TwrBsMxt = dataArray{:, 36};
TwrBsMyt = dataArray{:, 37};
TwrBsMzt = dataArray{:, 38};
GenPwr = dataArray{:, 39};
GenTq = dataArray{:, 40};
Wave1Elev = dataArray{:, 41};
FAIRTEN1 = dataArray{:, 42};
FAIRTEN2 = dataArray{:, 43};
FAIRTEN3 = dataArray{:, 44};
ANCHTEN1 = dataArray{:, 45};
ANCHTEN2 = dataArray{:, 46};
ANCHTEN3 = dataArray{:, 47};


%% Clear temporary variables
clearvars filename delimiter startRow endRow formatSpec fileID dataArray ans;