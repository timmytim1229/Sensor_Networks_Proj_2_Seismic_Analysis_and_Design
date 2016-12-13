% This function creates butterworth filter coeficients then a 
% filter with those values. The data is then transposed to keep dimension
% consistant for furture calculation.
%
% Input:
%   modeshapeFreq = freq band to filter around, 2-value array
%   data = sensor data
%
% Output:
%   data filtered about modeshapeFreq array

function filteredBandData = filterData(modeshapeFreq, data)

    % Butterworth filter (Convolve in the time domain)
    order = 3;
    [b,a] = butter(order, modeshapeFreq);

    % Filter data
    y = filter(b, a, data);

    % Transpose data for next processing step
    filteredBandData = y';