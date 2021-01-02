function SaveAllFigures

% It saves all the open figures in the specified "Folder"
% <https://it.mathworks.com/matlabcentral/answers/386880-how-can-i-save-instantaneously-all-plots-of-a-script#answer_308842>

Folder = fullfile(pwd);
AllFigH = allchild(groot);
    for iFig = 1:numel(AllFigH)
      fig = AllFigH(iFig);
      ax  = fig.CurrentAxes;
      ax.FontSize = 17;
      fig.PaperUnits = 'centimeter';
      fig.PaperPosition = [0 0 29.7 21];
      FileName = sprintf('Image%03d.png', iFig);
      saveas(fig, fullfile(Folder, FileName));
    end
end