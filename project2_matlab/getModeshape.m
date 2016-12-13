% This function finds the theoretical mode shapes from the mass and
% stiffness matrix
%
% Input:
%   K = stiffness matrix
%   M = mass matrix
%   eigenValue = value to check mode shape 
%
% Output:
%   modes of system

function modes = getModeshape(K, M, eigenValue)

    syms modeshape1 modeshape2

    % {[k] - wn^2[m]}*S = 0 ; S = Mode shape vector = mode shapes
    eigenMatrix = K - (M.*eigenValue);

    symb_modeshapes = [modeshape1; modeshape2];

    % Solve for mode shapes
    modeshapes = eigenMatrix*symb_modeshapes == 0;
    modeshape1 = 1;
    modeshapes = subs(modeshapes);
    modeshape2 = solve(modeshapes, modeshape2);

    modes = [modeshape1/modeshape2; modeshape2/modeshape2];