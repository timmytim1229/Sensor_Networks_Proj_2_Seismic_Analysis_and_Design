% This function finds power spectral density of sensor data using pwelch
%
% Input:
%   data = sensor data
%
% Output:
%   PSD and freq

function [Pxx, f] = getPSD(data, windowSize, overlap, samplingFreq, spectrum)

    % Get PSD from Welch
    [Pxx, f] = pwelch(data, windowSize, overlap, [], samplingFreq, spectrum);

    % Delete first two data points from Pxx and f due to noise
    Pxx(1,:) = [];      % 1 = row
    Pxx(1,:) = [];
    f(1,:) = [];
    f(1,:) = [];