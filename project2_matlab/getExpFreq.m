% This function finds the experimental freq of mode locations
%
% Input:
%   Pxx_mcf_band = psd of mcf data
%   f_psd_band = freq of PSD
%
% Output:
%   Range of location of mode freq

function f_exp_band = getExpFreq(Pxx_mcf_band, f_psd_band)

    % Get max value of the mcf psd and find the location of it
    [Pmax_mcf_band, index_Pmax_band] = max(Pxx_mcf_band);
    f_exp_band = f_psd_band(index_Pmax_band);