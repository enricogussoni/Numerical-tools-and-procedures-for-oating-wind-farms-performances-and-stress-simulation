load('heaveWS');

N = length(Time);
dt = Time(2)-Time(1); T = N*dt;
fsamp = 1/dt; df = 1/T;
freq = 0:df:df*N/2;

[fft_wave , freqW] = fft_norm(Wave1Elev,fsamp); 
wave_spectrum = abs(fft_wave); % vector of amplitude(freq)

% RAO_pitch = fft_pitch./fft_wave;

results = struct('heave',[],'pitch',[],'roll',[],'surge',[],'sway',[],'yaw',[]);

results.heave.timeHistory = PtfmHeave;
results.pitch.timeHistory = PtfmPitch;
results.roll.timeHistory = PtfmRoll;
results.surge.timeHistory = PtfmSurge;
results.sway.timeHistory = PtfmSway;
results.yaw.timeHistory = PtfmYaw;

results.heave.fft = fft_norm(results.heave.timeHistory,fsamp);
results.pitch.fft = fft_norm(results.pitch.timeHistory,fsamp);
results.roll.fft = fft_norm(results.roll.timeHistory,fsamp);
results.surge.fft = fft_norm(results.surge.timeHistory,fsamp);
results.sway.fft = fft_norm(results.sway.timeHistory,fsamp);
results.yaw.fft = fft_norm(results.yaw.timeHistory,fsamp);

results.heave.spectrum = abs(results.heave.fft);
results.pitch.spectrum = abs(results.pitch.fft);
results.roll.spectrum = abs(results.roll.fft);
results.surge.spectrum = abs(results.surge.fft);
results.sway.spectrum = abs(results.sway.fft);
results.yaw.spectrum = abs(results.yaw.fft);

results.heave.psd = PSD(results.heave.timeHistory,Time);
results.pitch.psd = PSD(results.pitch.timeHistory,Time);
results.roll.psd = PSD(results.roll.timeHistory,Time);
results.surge.psd = PSD(results.surge.timeHistory,Time);
results.sway.psd = PSD(results.sway.timeHistory,Time);
results.yaw.psd = PSD(results.yaw.timeHistory,Time);

results.heave.rao = results.heave.spectrum./wave_spectrum;
results.pitch.rao = results.pitch.spectrum./wave_spectrum; 
results.roll.rao = results.roll.spectrum./wave_spectrum; 
results.surge.rao = results.surge.spectrum./wave_spectrum; 
results.sway.rao = results.sway.spectrum./wave_spectrum; 
results.yaw.rao = results.yaw.spectrum./wave_spectrum; 

dofsNames = fieldnames(results);

for rp = size(dofsNames,1)
   
    data = results.(dofsNames{rp});
    
    figure(rp)
    plot(freqW,data.rao);

end


