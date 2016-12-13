% This function determines the Eigenvalues based on the mass and stiffness
% matrix.
%
% Input:
%   K = stiffness matrix
%   M = mass matrix
%
% Output:
%   Sorted array of Eigenvalues

function eigenValues = getEigenVals(K, M)

    syms lambda

    % det[[k]-wn^2[m]] = 0 ; where wn^2 = lambda
    eigenMatrix = K - (M.*lambda);
    d = det(eigenMatrix) == 0;

    % Sort from eigen values (lamba = L = eigenVals) lowest to highest
    eigenValues = sort(solve(d, lambda), 'ascend');