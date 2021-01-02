function  PSDloglog(Data,Time)
% Plots spectrum, power spectrum and power spectrum density of a signal.

N = length(Time);
dt = Time(2)-Time(1); T = N*dt;
fsamp = 1/dt; df = 1/T;

[A, frequency]=fft_norm(Data,fsamp);
A_star=conj(A);
Saa=A_star.*A;
Saa(2:end)=Saa(2:end)./2;
PSD=Saa./df;

figure
loglog(frequency,PSD,'m')
% set(gca,'fontsize',14)
grid on
title(inputname(1))         
xlabel('Frequency [Hz]')
ylabel('PSD')
xlim('auto');