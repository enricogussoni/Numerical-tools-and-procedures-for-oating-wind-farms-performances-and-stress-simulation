%% Plots

fprintf('\n Making plots \n')
format = 'jpg'; % Possible options: 'eps', 'jpg', 'png', 'pdf', 'svg', 'fig' [Default = 'fig']
maxFreq = 2.5; %[Hz] to limit useless outpt at high frequencies
lineWidth = 2; % Line width in plots
% savePicturesDir = directory;

neglectedFreqPos = find(Freq>maxFreq); % Ignored positions
cutFreqPos = neglectedFreqPos(1); % Last used term in the frequecy or psd vector

for pp = 2:(size(spectrumTable,2)-1)                           % spectrumTable.1 = frequences

    variableName = spectrumTable.Properties.VariableNames(pp); % Name of the variable whose PSD is plotted (cell-type variable)
    p=find(positions(:,pp)==1);
    
    figure(pp-1)
    if strcmp(semilogyPlots,'on')
        semilogy(Freq(1:cutFreqPos), Psd(1:cutFreqPos,pp));  hold on;
        semilogy(Freq(p), Psd(p,pp),'MarkerFaceColor',[1 0 0],'Marker','o','LineStyle','none'); hold off;
        xlabel('Frequency [Hz]'); ylabel('PSD');
        title([variableName "PSD peaks"]);
    else
        plot(Freq(1:cutFreqPos), Psd(1:cutFreqPos,pp),'LineWidth',lineWidth); hold on;
        plot(Freq(p), Psd(p,pp),'MarkerFaceColor',[1 0 0],'Marker','o','LineStyle','none'); hold off;
        xlabel('Frequency [Hz]'); ylabel('PSD');
        title([variableName "PSD peaks"]);
    end

    figureFileName = string(strcat(dof,variableName));
    switch format
        case {'eps'}
            print(figureFileName,'-depsc'); % saves in ".eps" format
        case {'jpg'}
            print(figureFileName,'-djpeg'); % saves in ".jpg" format
        case {'png'}
            print(figureFileName,'-dpng');  % saves in ".png" format
        case {'pdf'}
            print(figureFileName,'-dpdf');  % saves in ".pdf" format
        case {'svg'}
            print(figureFileName,'-dsvg');  % saves in ".svg" format
        otherwise
            savefig(figureFileName);        % saves in ".fig" format
    end
%    print(figureFileName,'-depsc'); % saves in ".eps" format
%    print(figureFileName,'-djpeg'); % saves in ".jpg" format
%    print(figureFileName,'-dpng');  % saves in ".png" format
%    print(figureFileName,'-dpdf');  % saves in ".pdf" format
%    print(figureFileName,'-dsvg');  % saves in ".svg" format
    close all
   

end
