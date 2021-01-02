function [correctedTable] = checkAndCorrectTable(dataTable)
%% Deletes columns full of 0 in dataTable created by the main script trough createDataTable
% TBN:(with the current version it is possible that some columns are undetected)

[r,c] = size(dataTable);
removedFlag = 0;

for kk = 1:c
    k = kk;                                           % Auxiliary variable that can cange inside the loop
    if kk > size(dataTable,2)                         % dataTable's size may decrease
        break
    end
    
    if removedFlag ==1
        k = kk-1;                                     % To check also the column next to the removed one
    end

    varName = dataTable.Properties.VariableNames(k);  % Column name inside the table
    varname = string(varName);                        % For fprintf
    
    localDataMatrix = table2array(dataTable);         % Format for comparison

    if localDataMatrix(:,k) == zeros(r,1)             % Checks if the column is full of 0
       dataTable(:,varName) = [];                     % If yes, it removes the column
       column = num2str(k);
       fprintf(['Removed ' varname{1} ' from column ' column '\n']);
       removedFlag = 1;                               % To notice that a column was removed
    else
       removedFlag = 0;
    end
    
end

correctedTable = dataTable;
