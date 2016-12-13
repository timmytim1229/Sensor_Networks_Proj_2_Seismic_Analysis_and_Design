% This function draws the PSD with Actual and Experimental frequency
%
% Input:
%   f = data freqs
%   Pxx = psd of data
%   expFrequencies = locations of modes
%   bands = range around expFrequencies
%
% Output:
%   PSD plot with experimental and theoretical frequencies

function drawPSD(f,Pxx,expFrequencies,bands)

    % Plotting
    fig = figure;
    fig.Name = 'Project 2: Experimental and Theoretical Mode Shape Frequencies';
    fig.Position = [360 278  720 420];
    hold on
    title('PSD');
    xlabel('Frequency (Hertz)');
    ylabel('Power');
    plot(f,Pxx);
    
    % Band is a column vector
    numBand = size(bands);
    
    % Get the maximum value of all the maximas
    for i=1:numBand(1)
        [maxim,maximIndex] = findMaxima(f,Pxx(:,1)',bands(i,:));
        maximSize = size(maxim);
        maximum = 0;

        for j=1:maximSize(2)
            if maxim(j) > maximum
                maximum = maxim(j);
                index = maximIndex(j);
            end
        end
        
        % Draw line indicating the frequencies
        hold on
        line([f(index),f(index)],[0,Pxx(index,1)],'LineWidth',1,'color','k','LineStyle','-');
        line([expFrequencies(i),expFrequencies(i)],[0,Pxx(index,1)],'LineWidth',1,'color','m','LineStyle','-');
    end

    legend('Floor 1','Floor 2','Floor 3','Experimental Frequencies','Theoretical Frequencies')
