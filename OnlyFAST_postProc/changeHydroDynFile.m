%% Test to modiphy HD files

WaveDir = 45;
HDpar = WaveDir; % A HD parameter list
TemplateFile = "NRELOffshrBsline5MW_OC4DeepCwindSemi_HydroDyn.dat"; % A .dat file to use as a template
OutputFilename = "Changed_HD.fst"; % Desired filename of output .fst file
hdrLines = 3; % Header lines???

Matlab2HD(HDpar,TemplateFile,OutputFilename,hdrLines);