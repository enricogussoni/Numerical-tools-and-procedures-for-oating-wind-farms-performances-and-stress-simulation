% 2D plots

% Plot example:
% figure()
% for pl = 1:nDir
% plot(Time,results(pl).dofs.heave.timeHistory);hold on
% %legendNames(pl) = num2str(dirVect(pl));
% end
% hold off;
% title('Heave time history'); xlabel('Time [s]'); ylabel('Heave [m]');
% %legend(legendNames);

if strcmp(makePlots,'on')
    
    figure(2)
    for pl = 1:nDir
        plot(freq,results(pl).dofs.heave.rao,'LineWidth',lineWidth); hold on
    end
    hold off;
    title(NameList{1}); xlabel('Frequency [Hz]'); %ylabel('Heave [m]');
    legend('0','30','60','90','120','150','180'); grid on
    figureName = NameList{1}; saveFigGiveFormat; % Save the figure
    

    figure(3)
    for pl = 1:nDir
        plot(freq,results(pl).dofs.pitch.rao,'LineWidth',lineWidth); hold on
    end
    hold off;
    title(NameList{2}); xlabel('Frequency [Hz]'); %ylabel('Pitch [m]');
    legend('0','30','60','90','120','150','180'); grid on
    figureName = NameList{2}; saveFigGiveFormat; % Save the figure
    
    figure(4)
    for pl = 1:nDir
        plot(freq,results(pl).dofs.roll.rao,'LineWidth',lineWidth); hold on
    end
    hold off;
    title(NameList{3}); xlabel('Frequency [Hz]'); %ylabel('Roll [m]');
    legend('0','30','60','90','120','150','180'); grid on
    figureName = NameList{3}; saveFigGiveFormat; % Save the figure
    
    figure(5)
    for pl = 1:nDir
        plot(freq,results(pl).dofs.surge.rao,'LineWidth',lineWidth); hold on
    end
    hold off;
    title(NameList{4}); xlabel('Frequency [Hz]'); %ylabel('Surge [m]');
    legend('0','30','60','90','120','150','180'); grid on
    figureName = NameList{4}; saveFigGiveFormat; % Save the figure

    figure(6)
    for pl = 1:nDir
        plot(freq,results(pl).dofs.sway.rao,'LineWidth',lineWidth); hold on
    end
    hold off;
    title(NameList{5}); xlabel('Frequency [Hz]'); %ylabel('Sway [m]');
    legend('0','30','60','90','120','150','180'); grid on
    figureName = NameList{5}; saveFigGiveFormat; % Save the figure

    figure(7)
    for pl = 1:nDir
        plot(freq,results(pl).dofs.yaw.rao,'LineWidth',lineWidth); hold on
    end
    hold off;
    title(NameList{6}); xlabel('Frequency [Hz]'); %ylabel('Yaw [m]');
    legend('0','30','60','90','120','150','180'); grid on
    figureName = NameList{6}; saveFigGiveFormat; % Save the figure
% 
% end
% 
% close all
% system(['move *RAO* ' savePicsDir]); % Moves pictures into main folder
% clear figureName;