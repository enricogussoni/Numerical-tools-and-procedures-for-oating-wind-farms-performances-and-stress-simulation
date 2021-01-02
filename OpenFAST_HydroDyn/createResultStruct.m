results(count).dofs.heave.timeHistory = PtfmHeave;
results(count).dofs.pitch.timeHistory = PtfmPitch;
results(count).dofs.roll.timeHistory = PtfmRoll;
results(count).dofs.surge.timeHistory = PtfmSurge;
results(count).dofs.sway.timeHistory = PtfmSway;
results(count).dofs.yaw.timeHistory = PtfmYaw;

results(count).dofs.heave.fft = fft_norm(results(count).dofs.heave.timeHistory,fsamp);
results(count).dofs.pitch.fft = fft_norm(results(count).dofs.pitch.timeHistory,fsamp);
results(count).dofs.roll.fft = fft_norm(results(count).dofs.roll.timeHistory,fsamp);
results(count).dofs.surge.fft = fft_norm(results(count).dofs.surge.timeHistory,fsamp);
results(count).dofs.sway.fft = fft_norm(results(count).dofs.sway.timeHistory,fsamp);
results(count).dofs.yaw.fft = fft_norm(results(count).dofs.yaw.timeHistory,fsamp);

results(count).dofs.heave.spectrum = abs(results(count).dofs.heave.fft);
results(count).dofs.pitch.spectrum = abs(results(count).dofs.pitch.fft);
results(count).dofs.roll.spectrum = abs(results(count).dofs.roll.fft);
results(count).dofs.surge.spectrum = abs(results(count).dofs.surge.fft);
results(count).dofs.sway.spectrum = abs(results(count).dofs.sway.fft);
results(count).dofs.yaw.spectrum = abs(results(count).dofs.yaw.fft);

results(count).dofs.heave.psd = PSD(results(count).dofs.heave.timeHistory,Time);
results(count).dofs.pitch.psd = PSD(results(count).dofs.pitch.timeHistory,Time);
results(count).dofs.roll.psd = PSD(results(count).dofs.roll.timeHistory,Time);
results(count).dofs.surge.psd = PSD(results(count).dofs.surge.timeHistory,Time);
results(count).dofs.sway.psd = PSD(results(count).dofs.sway.timeHistory,Time);
results(count).dofs.yaw.psd = PSD(results(count).dofs.yaw.timeHistory,Time);

results(count).dofs.heave.rao = results(count).dofs.heave.spectrum./wave_spectrum;
results(count).dofs.pitch.rao = results(count).dofs.pitch.spectrum./wave_spectrum; 
results(count).dofs.roll.rao = results(count).dofs.roll.spectrum./wave_spectrum; 
results(count).dofs.surge.rao = results(count).dofs.surge.spectrum./wave_spectrum; 
results(count).dofs.sway.rao = results(count).dofs.sway.spectrum./wave_spectrum; 
results(count).dofs.yaw.rao = results(count).dofs.yaw.spectrum./wave_spectrum; 