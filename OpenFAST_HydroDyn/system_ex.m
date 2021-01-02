g=num2str(0);

mainDir = 'C:\Users\Enrico\GUSS\POLIMI\TESI\OpenFAST_HydroDyn\variable_WaveDir\'

caseDIR = [mainDir g 'deg\Test25.fst']
fastDIR = ['C:\Users\Enrico\GUSS\POLIMI\TESI\FAST_runFiles\FAST_x64d.exe ']  % Mind the space at the end!
system([fastDIR caseDIR],'-echo');