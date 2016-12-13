% This function finds maxima of the graph
%
% Input:
%   x array = time values that correspond to y (acceleration)
%   y array = acceleration values that correspond to x (time)
%   range = time range from must be within the x (time) domain
%
% Output:
%   Array of max values of signal

function [maxim,maximIndex] = findMaxima(x,y,range)

    [maxim,maximIndex] = findpeaks(y);
    xRange = x(maximIndex);
    xSize = size(maximIndex);

    % Get starting index
    for i=1:xSize(2);
        if xRange(i) >= range(1)
            startIndex = i;
            break;
        end
    end

    % Get ending index
    for i=1:xSize(2)
        if i == xSize(2)
            endIndex = i;
            break;
        end
        if xRange(i) >= range(2)
            endIndex = i-1;
            break;
        end
    end

    newMaxim = zeros(1,endIndex-startIndex+1);
    newMaximIndex = zeros(1,endIndex-startIndex+1);
    newMaxim(1:endIndex-startIndex+1) = maxim(startIndex:endIndex);
    newMaximIndex(1:endIndex-startIndex+1) = maximIndex(startIndex:endIndex);

    maxim = newMaxim;
    maximIndex = newMaximIndex;
