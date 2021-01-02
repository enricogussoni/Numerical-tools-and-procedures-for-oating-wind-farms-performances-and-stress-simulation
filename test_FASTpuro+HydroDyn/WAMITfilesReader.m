%% WAMIT files reader to read .hst, .1 and .3 files that HydroDyn uses from WAMIT
% References: 
% - WAMIT User Manual (http://www.engr.mun.ca/~bveitch/courses/8000/software/wamit/wamit.pdf)
% - HydroDyn User’s Guide and Theory Manual (https://nwtc.nrel.gov/system/files/HydroDyn_Manual_0.pdf)

clear all
close all
clc

%% DATA IMPORT
% Problemi in loading the data, the sintax

% % out.hst
% hst = load('marin_semi.hst','-ascii');

% doesn't work.

load marin_semiWAMIT.mat

%% DATA ANALYSIS

% Hydrostatic matix
i_ind = dotHst(:,1); % i
j_ind = dotHst(:,2); % j
c_coef = dotHst(:,3); % C(i,j) = elements of the hydrostatic matix
C = zeros(6);
c = c_coef;

for nr = 1:6 
    row = c(1:6,1);
    C(nr,:) = row(1:end)'; % hydrostatic matix
    if nr ~= 6
        c = c(7:end);
    else
    end
end

disp('Hydrostatic matrix:')
disp(C)

% Added mass and damping
PER = dotOne(:,1);
i_ind = dotOne(:,2);
j_ind = dotOne(:,3);
Aall = dotOne(:,4);
Ball = dotOne(:,5);

n_samp = max(find(dotOne==dotOne(1,1))); % number of samples for every period
dock = dotOne;
coef_ind = dock(1:n_samp,2:3);  % every row is the ij name of a coefficient
periods = dock(1:n_samp:end,1); % vector of evaluated periods
periods = periods(end:-1:1); 
frequencies = periods.^(-1);    % vector of evaluated frequencies

A = zeros(length(periods),n_samp); B = zeros(length(periods),n_samp);
% A nad B are matrixes in witch every column correspond to a coefficient and
% every row to a period/frequency
for pp = 1:n_samp
    A(:,pp) = dock(pp:n_samp:end,4); % Added mass matrix
    B(:,pp) = dock(pp:n_samp:end,5); % Adde damping
end

% for qq = 1:n_samp
%     figure(qq)
%     plot(A(1:(end-2),qq),periods(1:(end-2))); hold on
%     plot(B(1:(end-2),qq),periods(1:(end-2))); hold off
% end

for qq = 1:n_samp
    ij = [coef_ind(qq,1) coef_ind(qq,2)];
    
    figure(qq)
    plot(frequencies(1:(end-2)),A((end-2):-1:1,qq)); hold on
    plot(frequencies(1:(end-2)),B((end-2):-1:1,qq)); hold off
    xlabel('Frequency [Hz]'); ylabel(['Coeff. index ',num2str(ij)]);
    legend('A','B');
end

%% 