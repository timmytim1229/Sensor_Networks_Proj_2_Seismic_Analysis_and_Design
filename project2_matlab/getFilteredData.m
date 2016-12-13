% This function finds the exact experimental freq of modes
%
% Input:
%   data = sensor data
%   modeshapeFreqs = band of mode freqs
%   samplingFreq = how fast to sample data
%
% Output:
%   Filtered band data

function filteredBandData = getFilteredData(data, modeshapeFreqs, samplingFreq)

    % Filter (after ran on shake table) to remove noise and alias.
    modeshapeFreqs = modeshapeFreqs.*2./samplingFreq;       % Convert to hz
    filteredBandData = filterData(modeshapeFreqs, data);    % USER DEFINED