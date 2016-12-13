% This function creates 3 plots with function handles then 
% plots the input data x, y1, y2, y3 based on the figures
% and plots.
%
% Input:
%   x = time values
%   y0 = ground sensor array
%   y1 = floor 1 sensor array
%   y2 = floor 2 sensor array
%   y3 = floor 3 sensor array
%
% Output:
%   sensor data plot

function plotSensorData(x, y0, y1, y2, y3)

    % Create the plots and figures
    fig1 = figure;
    fig1.Name = 'Ground';
    h1 = plot(x, y0);
    h1.LineWidth = 2;
    h1.MarkerSize = 10;
    h1.MarkerEdgeColor = [1 0 0];
    h1.MarkerFaceColor = [1 0 0];
    title('Acceleration Over Time: Ground');
    xlabel('Time (s)');
    ylabel('Acceleration (g)');

    fig2 = figure;
    fig2.Name = 'Floor 1';
    h2 = plot(x, y1);
    h2.LineWidth = 2;
    h2.MarkerSize = 10;
    h2.MarkerEdgeColor = [1 0 0];
    h2.MarkerFaceColor = [1 0 0];
    title('Acceleration Over Time: Floor 1');
    xlabel('Time (s)');
    ylabel('Acceleration (g)');

    fig3 = figure;
    fig3.Name = 'Floor 2';
    h3 = plot(x, y2);
    h3.LineWidth = 2;
    h3.MarkerSize = 10;
    h3.MarkerEdgeColor = [1 0 0];
    h3.MarkerFaceColor = [1 0 0];
    title('Acceleration Over Time: Floor 2');
    xlabel('Time (s)');
    ylabel('Acceleration (g)');
    
    fig3 = figure;
    fig3.Name = 'Floor 3';
    h3 = plot(x, y3);
    h3.LineWidth = 2;
    h3.MarkerSize = 10;
    h3.MarkerEdgeColor = [1 0 0];
    h3.MarkerFaceColor = [1 0 0];
    title('Acceleration Over Time: Floor 3');
    xlabel('Time (s)');
    ylabel('Acceleration (g)');
    
    % Plot the data sets in real time
    %h1.YData = y1;
    %h2.YData = y2;
    %h3.YData = y3;
    %h1.XData = x;
    %h2.XData = x;
    %h3.XData = x;