%% Save figures with given format
% requires 'givenFormat' and 'figureTitle'

switch givenFormat
    case {'eps'}
        print(figureName,'-depsc'); % saves in ".eps" format
    case {'jpg'}
        print(figureName,'-djpeg'); % saves in ".jpg" format
    case {'png'}
        print(figureName,'-dpng');  % saves in ".png" format
    case {'pdf'}
        print(figureName,'-dpdf');  % saves in ".pdf" format
    case {'svg'}
        print(figureName,'-dsvg');  % saves in ".svg" format
    otherwise
        savefig(figureName);        % saves in ".fig" format
end