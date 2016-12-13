% This function automatically finds band of the peaks about a threshold
%
% Input:
%   data = sensor data
%
% Output:
%   Nx2 freq band matrix, N = num of bands

function bands = findBand(data)
    [maxima,maximaIndex]=findpeaks(data);
    maximaize = size(maxima);
    thresh = .001;
    newmaxima = [];
    peakIndex = [];
    ptr = 0;
    for i=1:maximaize(1)
        if maxima(i) > thresh
            ptr = ptr + 1;
            newmaxima(ptr) = maxima(i);
            peakIndex(ptr) = maximaIndex(i);
        end
    end
    numBand = ptr;
    
    % Find local minima
    invertData = 1.01*max(data) - data;
    [minima,minimaIndex] = findpeaks(invertData);
    minima = data(minimaIndex);

    % Column vector
    minimaSize = size(minima);

    newMinIndex = [];
    ptr = 0;
    for i=1:numBand
        for j=1:minimaSize(1);
            if minimaIndex(j) > peakIndex(i)
                ptr = ptr + 1;
                offset = 0;
                if i>1
                    offset = 1;
                end
                newMinIndex(ptr,:) = [minimaIndex(j-1)+offset,minimaIndex(j)];
                break
            end
        end
    end
    bands = newMinIndex;
    
    