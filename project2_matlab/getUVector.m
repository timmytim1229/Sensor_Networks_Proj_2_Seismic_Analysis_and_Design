% This function finds the modes of the system
%
% Input:
%   data = sensor data
%   filteredBandData = data passed through butterworth filter
%
% Output:
%   mode shape vector

function u_vector = getUVector(data, filteredBandData)

    % Now have each filteredBandData=CxN matrix (1 for each band)
    % C = number of sensors (rows), N = number of data points (cols)

    % Compute power of signal for each band
    powerBand = filteredBandData*filteredBandData.';

    % Now have a CxC matrix where the cols are the modeshapes for each specific band

    % Compute Singular Vector Decomposition (SVD) for each band
    % E = U*S*V'
    % U_band = CxC of eigen vectors (of E*E')
    % S_band = Diagonal matrix of size CxC, sqrts of eigenvalues of E*E' (wn's)
    % V_band = Eigen vectors (of E'*E)
    [U_band,S_band,V_band] = svd(powerBand);

    u_vector = U_band(:,1);