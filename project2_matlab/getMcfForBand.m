% This function computed the modal contribution factor (MCF) of filtered
% data and mode
%
% Input:
%   U = mode vector
%   filteredBandData = data to be processed
%
% Output:
%   band of mcf freq, 1XN array

function MCF_band = getMcfForBand(U, filteredBandData)

    % MCF calculation
    scalar_val = (1./(U(:,1).'*U(:,1)));
    MCF_band = scalar_val.*(U(:,1).'*filteredBandData);