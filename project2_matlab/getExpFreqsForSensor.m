% This function finds the exact experimental freq of modes
%
% Input:
%   U_band = mode vector
%   filteredBandData = filtered data
%
% Output:
%   Exact experimental freq of mode

function expFreqSensor = getExpFreqsForSensor(U_band, filteredBandData, windowSize, overlap, samplingFreq, spectrum)

    % Find experimental modeshape of the band (Experimental approx range).
    % Compute Modal Contribution Factor of each band of the ground sensor.
    %
    % U(:,1) first column of U is the modeshape vector for this freq band.
    % USE U(:,1) TO DETECT DAMAGE, compare to RISA
    MCF_band = getMcfForBand(U_band, filteredBandData);  % USER DEFINED

    % Compute PSD of MCF of of the band to get the power of the signal
    % then the exact value and location of modeshapes
    [Pxx_mcf_band, f_psd_band] = pwelch(MCF_band, windowSize, overlap, [], samplingFreq, spectrum);

    % Find the exact frequency of where the PSD (of original PSD plot) peak is
    f_exp_band = getExpFreq(Pxx_mcf_band, f_psd_band); % USER DEFINED

    expFreqSensor = f_exp_band;