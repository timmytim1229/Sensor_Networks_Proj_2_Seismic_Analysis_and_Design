% This function plots the PSD
%
% Input:
%   f = PSD freqs
%   Pxx = PSD data
%
% Output:
%   PSD plot

function plotPSD(f, Pxx)

    figure
    plot(f,Pxx(:,1),'g',f,Pxx(:,2),'b',f,Pxx(:,3),'r');
    title('PSD');
    title('Power Spectral Density');
    xlabel('Frequency (Hz)');
    ylabel('Power');
    legend('Floor1', 'Floor2', 'Floor3');