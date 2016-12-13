% This function finds maxima of the acceleration over time graph
%
% Input:
%   x array = time values that correspond to y (acceleration)
%   y array = acceleration values that correspond to x (time)
%   tRange = time range from must be within the x (time) domain
%
% Output:
%   Array of max accel
%
function [maxim,maximIndex] = findMaxima(x,y,tRange)

    [maxim,maximIndex] = findpeaks(y);
    xRange = x(maximIndex);
    xSize = size(maximIndex);

    fig = figure;
    fig.Name = 'Project 2';
    fig.Position = [360 278  720 420];
    hold on
    title('Acceleration Over Time with Maxima');
    xlabel('Time(s)');
    ylabel('Acceleration(g)');

    % Get starting index
    for i=1:xSize(2);
        if xRange(i) >= tRange(1)
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
        if xRange(i) >= tRange(2)
            endIndex = i;
            break;
        end
    end

    newMaxim = zeros(1,endIndex-startIndex+1);
    newMaximIndex = zeros(1,endIndex-startIndex+1);
    newMaxim(1:endIndex-startIndex+1) = maxim(startIndex:endIndex);
    newMaximIndex(1:endIndex-startIndex+1) = maximIndex(startIndex:endIndex);

    maxim = newMaxim;
    maximIndex = newMaximIndex;

    maximSize = size(maximIndex);
    for i=1: maximSize(2) 
        text(x(maximIndex(i)),maxim(i)-5,['(',num2str(maximIndex(i)),', ',num2str(maxim(i)),')'],'FontSize',10);
    end

    plot(x,y-5,x(maximIndex),maxim-5,'xr');
    legend('Acceleration decay','Maxima');