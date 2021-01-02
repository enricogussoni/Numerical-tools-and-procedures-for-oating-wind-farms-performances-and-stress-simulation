function [psd,frequency] =  PSD(Data,Time)
% Evaluate Power Spectrum Density.

N = length(Time);
dt = Time(2)-Time(1); T = N*dt;
fsamp = 1/dt; df = 1/T;

[A, frequency]=fft_norm(Data,fsamp);
A_star=conj(A);
Saa=A_star.*A;
Saa(2:end)=Saa(2:end)./2;
psd=Saa./df;
end