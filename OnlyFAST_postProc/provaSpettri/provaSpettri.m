%% Test script to better compare PSD of different signals not only grafically 
% but mathematically.

clear all
close all
clc

%% Loading data

data = Test25;
time = data(:,1);
psd = zeros(height(data),width(data));

for cc = 1:width(data)
     
    psd(:,cc) = pwelch(data(:,cc));

end

