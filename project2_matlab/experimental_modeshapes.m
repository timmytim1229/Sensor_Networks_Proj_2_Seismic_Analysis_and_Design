% Project 2 Seismic Analysis and Design
% ECPE/CIVL 259: Sensor Networks Fall 2016
% University of the Pacific
% Group: Kelvin Flores, Marcus Moreno, Amanveer Pamma, Tim Weatherwax
%
% GOAL: The goal of this project is to monitor vibration properties and 
%       motion of a model building system subject to random ground motions.
%
% LEARNING OBJECTIVES:
% 1) Design a system, using sensors, to characterize the vibration properties of a model building system.
% 2) Design and build a model building system to resist a severe earthquake event.
% 3) Design and build a seismic dampening system to improve the model building?s survivability.
% 4) Compare theoretical vibration properties to experimentally measured vibration properties.
% 5) Monitor the vibration of the building system in real-time during an earthquake.
%
% TASKS:
% 1) Design and construction of a building system under a set of given constraints.
% 2) Design and implementation of a sensor system to experimentally measure vibration properties and monitor structural performance in real time.
% 3) Structural analysis and theoretical prediction of vibration properties using RISA 3-D.
% 4) Experimental measurement of vibration properties and comparison to theoretical properties.
% 5) Detecting structural performance changes via real-time monitoring during an earthquake.
% 6) Design and construction of a seismic dampening system.
% 7)Communication of project, methods, and findings via written report and oral presentation.
%
%% Data Reading from Serial Port
% Create Serial Object
ser = serial('/dev/cu.usbmodem0E214131','BaudRate',57600);
fopen(ser);

% Set time
execTime = 35;      % DEPENDS ON SHAKE TABLE TIME

x = [0];
y0 = [0];
y1 = [0];
y2 = [0];
y3 = [0];

s = [1,1]

% Start data acquisition
while x(s(2)) < execTime
    tic
    fprintf(ser,'K');           % Tell microcontroller to send
    
    val1 = fscanf(ser,'%d');    % Acquire a character from the serial port
    val2 = fscanf(ser,'%d');  
    val3 = fscanf(ser,'%d');  
    val0 = fscanf(ser,'%d'); 

    s = size(y1);
    x(s(2)+1) = x(s(2)) + toc;            % time 
    
    y0(s(2)+1) = (val0*3.3)/(4096*.33);   % data, s(2) = column growth
    y1(s(2)+1) = (val1*3.3)/(4096*.33);   
    y2(s(2)+1) = (val2*3.3)/(4096*.33);   
    y3(s(2)+1) = (val3*3.3)/(4096*.33);   
end

fclose(ser);

% Plot the data 
plotSensorData(x, y0, y1, y2, y3);              % USER DEFINED

%% Calculate Power Spectural Density and Plot it

% y0 = ground floor, not used
% y1 = floor 1, column 1
% y2 = floor 2, column 2
% y3 = floor 3, column 3
data = [y1; y2; y3]';   % NxC Matrix (N = number of data points, C = number of sensors)

% Get the Power Spectural Densities of all sensor data
% PSD settings
windowSize = 512;
overlap = 510;
samplingFreq = 60;      % Nyquist, half the maximum data rate (121.3 Hz measured to read 4 sensors on a microcontroller and send the data over UART)
spectrum = 'onesided';  % Only want the positive side of the PSD
[Pxx, f] = getPSD(data, windowSize, overlap, samplingFreq, spectrum);    % USER DEFINED, f in Hz

% Plot the PSD of each sensor
% # peaks = # modes
plotPSD(f, Pxx);                % USER DEFINED

%% Process the Data to Find Experimental Modeshapes

% One modeshape vector (modes) for each lambda (eigen values)
% Each degree of freedom = one eigen value 
% Therefore, at least one modeshape vector for each degree of freedom
% Should see three mode shapes

% Dynamically determine freq bands where modes occur
bandIndex = findBand(Pxx(:,1));
sizeBand = size(bandIndex);
numBands = sizeBand(1);
uVectorBands = [];
expModeshapeFrequencies = [];

% Loop over amount of bands
for i=1:numBands
    % Get freq bands from the frequency data
    bands(i,:) = [f(bandIndex(i,1)),f(bandIndex(i,2))];
    
    % Set mode shape frequency band
    modeshapeFreq = bands(i,:);
    
    % Filter data from the calculated band
    filteredBandData = getFilteredData(data, modeshapeFreq, samplingFreq);
    
    % Calculate mode shapes
    uVectorBand = getUVector(data, filteredBandData);
    
    % Calculate experimental frequency of the mode shape vector
    expModeshapeFreq = getExpFreqsForSensor(uVectorBand, filteredBandData, windowSize, overlap, samplingFreq, spectrum);
    
    % Save the bands and freqs
    uVectorBands(i,:) = uVectorBand;
    expModeshapeFrequencies(i) = expModeshapeFreq;
    
    % Draw mode shapes
    drawMS(uVectorBand,i);
end

% Draw PSD w/ Exp Freq
% Three bands for each sensor 
drawPSD(f',Pxx,expModeshapeFrequencies,bands);

